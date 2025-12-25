import SwiftUI
import RealityKit
import ARKit

/// A lightweight RealityKit viewer that operates in non-AR preview mode or AR placement mode.
/// Designed to be low-risk: uses bundled USDZ files, loads ModelEntity asynchronously, shows progress and errors.
struct RealityKitViewer: View {
    let modelName: String
    @Environment(\.dismiss) private var dismiss

    @State private var loading = true
    @State private var loadError: String? = nil
    @State private var entity: ModelEntity? = nil
    @State private var arMode = false

    // Track the active load task so we can cancel when the view changes or disappears.
    @State private var loadTask: Task<Void, Never>? = nil

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 12) {
                header

                ZStack {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.white.opacity(0.04))

                    Group {
                        if loading {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.2)
                        } else if let err = loadError {
                            VStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.system(size: 36))
                                    .foregroundColor(.yellow)
                                Text("Failed to load: \(err)")
                                    .foregroundColor(.white.opacity(0.85))
                                    .multilineTextAlignment(.center)
                            }
                            .padding(20)
                        } else if let entity {
                            if arMode {
                                ARRealityKitContainer(entity: entity)
                                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                                    .padding(8)
                            } else {
                                NonARRealityKitContainer(entity: entity)
                                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                                    .padding(8)
                            }
                        } else {
                            EmptyView()
                        }
                    }
                }
                .padding()

                HStack {
                    Toggle("AR Mode", isOn: $arMode)
                        .labelsHidden()

                    Spacer()

                    Button { dismiss() } label: {
                        Text("Close")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 18)
                            .background(Color.white.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            }
            .padding(.top, 12)
        }
        .task(id: modelName) {
            // Cancel any previous loader for safety and start a new one bound to this view's modelName.
            loadTask?.cancel()
            loadTask = Task {
                await loadModel()
            }
        }
        .onChange(of: arMode) { _ in
            // Force a small reload to ensure AR/non-AR containers reconfigure if needed.
            Task { await loadModel() }
        }
        .onDisappear {
            loadTask?.cancel()
            loadTask = nil
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(modelName)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text("RealityKit Preview")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.65))
            }
            Spacer()
            Button { dismiss() } label: { Image(systemName: "xmark.circle.fill").font(.system(size: 26)).foregroundColor(.white) }
                .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
    }

    private func loadModel() async {
        loading = true
        loadError = nil

        // If task was cancelled before we start, bail out early.
        if Task.isCancelled { return }

        // Try cached copy first (fast path)
        if let cached = try? await ModelCache.shared.getClone(for: modelName) {
            await MainActor.run {
                self.entity = cached
                self.loading = false
            }
            return
        }

        // Try to find a bundled USDZ URL first
        if let url = Bundle.main.url(forResource: modelName, withExtension: "usdz") {
            do {
                let loaded = try await ModelEntity.loadModelAsync(contentsOf: url).value

                // Cache the loaded original entity (so subsequent requests return clones)
                await ModelCache.shared.set(loaded, for: modelName)

                // Return a clone to the UI so we don't hand out the cached instance directly.
                let clone = try? await ModelCache.shared.getClone(for: modelName)

                await MainActor.run {
                    self.entity = clone
                    self.loading = false
                }
            } catch {
                // If cancelled, don't report a user-facing error.
                if Task.isCancelled { return }
                await MainActor.run {
                    self.loadError = error.localizedDescription
                    self.loading = false
                }
            }
            return
        }

        // Fallback: attempt to load by name from bundle resources
        do {
            let result = try await Entity.loadAsync(named: modelName).value
            if let modelEntity = result as? ModelEntity {
                await ModelCache.shared.set(modelEntity, for: modelName)
                let clone = try? await ModelCache.shared.getClone(for: modelName)
                await MainActor.run {
                    self.entity = clone
                    self.loading = false
                }
            } else {
                await MainActor.run {
                    self.loadError = "Loaded entity is not a ModelEntity"
                    self.loading = false
                }
            }
        } catch {
            if Task.isCancelled { return }
            await MainActor.run {
                self.loadError = error.localizedDescription
                self.loading = false
            }
        }
    }
}

// MARK: - AR Container

private struct ARRealityKitContainer: UIViewRepresentable {
    let entity: ModelEntity

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic

        // If scene reconstruction (mesh) is supported, enable it for improved occlusion
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }

        // Enable person segmentation depth if supported (helps occlusion of people)
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            config.frameSemantics.insert(.personSegmentationWithDepth)
        }

        arView.setupForAR(configuration: config)

        // Place a copy of the entity on a simple anchor
        let anchor = AnchorEntity(plane: .horizontal)
        entity.generateCollisionShapes(recursive: true)
        anchor.addChild(entity.clone(recursive: true))
        arView.scene.anchors.append(anchor)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

// MARK: - Non-AR Container

private struct NonARRealityKitContainer: UIViewRepresentable {
    let entity: ModelEntity

    func makeUIView(context: Context) -> ARView {
        // Use ARView in non-AR camera mode for high-quality rendering without running an AR session.
        let arView = ARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: false)
        let anchor = AnchorEntity()
        anchor.addChild(entity.clone(recursive: true))
        arView.scene.anchors.append(anchor)

        // Gentle default camera transform to showcase the model.
        arView.cameraTransform = Transform(pitch: .radians(-0.2), yaw: .zero, roll: .zero, translation: [0, 0.1, 0.8])

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

// MARK: - ARView helper

private extension ARView {
    func setupForAR(configuration: ARConfiguration) {
        guard ARWorldTrackingConfiguration.isSupported else { return }
        session.run(configuration, options: [])
    }
}