import SwiftUI
import SceneKit

// Lightweight inline scene cache to avoid touching the Xcode project file.
private final class InlineSceneCache {
    static let shared = InlineSceneCache()
    private let cache = NSCache<NSString, SCNScene>()
    private init() {
        cache.countLimit = 12
        cache.totalCostLimit = 200 * 1024 * 1024
    }

    func scene(for name: String) -> SCNScene? {
        cache.object(forKey: name as NSString)
    }

    func set(_ scene: SCNScene, for name: String) {
        cache.setObject(scene, forKey: name as NSString, cost: 1)
    }

    func removeScene(named name: String) {
        cache.removeObject(forKey: name as NSString)
    }

    func loadSceneNamed(_ name: String) async -> SCNScene? {
        if let cached = scene(for: name) { return cached }
        return await withCheckedContinuation { cont in
            DispatchQueue.global(qos: .userInitiated).async {
                let exts = ["usdz", "scn", "dae"]
                var loaded: SCNScene? = nil
                for ext in exts {
                    if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                        if let scene = try? SCNScene(url: url, options: nil) {
                            loaded = scene
                            break
                        }
                        if let scene = SCNScene(named: "\(name).\(ext)") {
                            loaded = scene
                            break
                        }
                    }
                }
                if let s = loaded { InlineSceneCache.shared.set(s, for: name) }
                cont.resume(returning: loaded)
            }
        }
    }
}

struct ModelViewerSheet: View {
    let modelName: String
    @Environment(\.dismiss) private var dismiss

    private var usdzName: String { "\(modelName).usdz" }

    @State private var scene: SCNScene? = nil
    @State private var loading = true

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 14) {
                header

                ZStack {
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(Color.white.opacity(0.06))

                    Group {
                        if loading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.2)
                                .padding(20)
                        } else if let scene {
                            SceneView(
                                scene: scene,
                                pointOfView: defaultCamera(),
                                options: [
                                    .autoenablesDefaultLighting,
                                    .allowsCameraControl
                                ]
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                            .padding(10)
                        } else {
                            fallback
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 18)
            }
            .padding(.top, 10)
        }
        .task {
            await loadScene()
        }
    }

    private var header: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(modelName)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("3D Preview")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.65))
            }

            Spacer()

            Button { dismiss() } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.85))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 6)
    }

    private func defaultCamera() -> SCNNode {
        let cam = SCNCamera()
        cam.fieldOfView = 55

        let node = SCNNode()
        node.camera = cam
        node.position = SCNVector3(0, 0.05, 0.75)
        return node
    }

    private func loadScene() async {
        loading = true
        // Use the inline cache to load the scene off-main and reuse cached instances.
        if let loaded = await InlineSceneCache.shared.loadSceneNamed(modelName) {
            await MainActor.run {
                self.scene = loaded
                self.loading = false
            }
        } else {
            await MainActor.run {
                self.scene = nil
                self.loading = false
            }
        }
    }

    private var fallback: some View {
        VStack(spacing: 10) {
            Image(systemName: "cube.transparent")
                .font(.system(size: 42, weight: .semibold))
                .foregroundStyle(.white.opacity(0.8))

            Text("Couldn’t load \(usdzName)")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(.white.opacity(0.8))

            Text("Check Target Membership + Copy Bundle Resources.")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.55))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding(20)
    }
}