import SwiftUI
#if os(iOS)
import QuickLook
#endif
#if os(macOS)
import AppKit
import SceneKit
#endif

// MARK: - Product Detail

struct ProductDetailView: View {
    let product: Product
    /// When presented as a sheet on macOS, we show a close button.
    var showsCloseButton: Bool = false

    @EnvironmentObject var store: StoreModel
    @Environment(\.dismiss) private var dismiss

    @State private var showingModel = false
    @State private var isUpdatingFirmware = false  // placeholder for future

    private var hasModel: Bool { product.modelName != nil }
    private var isOwned: Bool { store.isAcquired(product) }
    private var isWishlisted: Bool { store.isWishlisted(product) }

    var body: some View {
        ZStack {
            AquireBackgroundView()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Optional close for macOS sheet
                if showsCloseButton {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.white.opacity(0.85))
                        }
                        .buttonStyle(.plain)

                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                }

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Hero card
                        ProductCard(
                            product: product,
                            hasModel: product.modelName != nil,
                            isOwned: store.isAcquired(product)
                        )
                        // Overview / description
                        VStack(alignment: .leading, spacing: 8) {
                            Text(product.category.uppercased())
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.purple.opacity(0.9))

                            Text(product.description)
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.9))
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        // Compatibility – static for now
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Compatibility")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)

                            VStack(alignment: .leading, spacing: 4) {
                                bullet("FoundationOS 2.0 and later")
                                bullet("Pairs with OnyxGlove, OnyxSuit, Foundation Dock")
                            }
                        }

                        // CTA buttons
                        actionButtonsSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
        }
        #if os(iOS)
        .fullScreenCover(isPresented: $showingModel) {
            if let modelName = product.modelName,
               let url = Bundle.main.url(forResource: modelName, withExtension: "usdz") {
                ModelQuickLookView(url: url, isPresented: $showingModel)
                    .ignoresSafeArea()
            } else {
                AquireBackgroundView()
                    .overlay(
                        Text("3D model not found.")
                            .foregroundColor(.white)
                    )
            }
        }
        #endif
        #if os(macOS)
        .sheet(isPresented: $showingModel) {
            if let modelName = product.modelName,
               let url = Bundle.main.url(forResource: modelName, withExtension: "usdz") {
                MacModelSheet(url: url, productName: product.name)
            } else {
                ZStack {
                    AquireBackgroundView()
                    Text("3D model not found.")
                        .foregroundColor(.white)
                }
            }
        }
        #endif
    }

    // MARK: - Buttons

    private var actionButtonsSection: some View {
        VStack(spacing: 14) {
            // View in 3D
            Button {
                if hasModel {
                    showingModel = true
                }
            } label: {
                HStack {
                    Image(systemName: "sparkles.rectangle.stack.fill")
                    Text(hasModel ? "View in 3D" : "No 3D Model")
                    Spacer()
                }
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .background(
                    Capsule(style: .continuous)
                        .fill(Color.purple.opacity(0.95))
                )
            }
            .buttonStyle(.plain)
            .opacity(hasModel ? 1.0 : 0.4)
            .disabled(!hasModel)
            .pressable()

            // Wishlist – same layout both states, so no jank
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.9)) {
                    store.toggleWishlist(for: product)
                }
            } label: {
                HStack {
                    Image(systemName: isWishlisted ? "star.fill" : "star")
                    Text(isWishlisted ? "In Wishlist" : "Add to Wishlist")
                    Spacer()
                }
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .background(
                    Capsule(style: .continuous)
                        .fill(Color.white.opacity(0.08))
                )
            }
            .buttonStyle(.plain)
            .pressable()

            // Acquire
            Button {
                handleAcquire()
            } label: {
                HStack {
                    Image(systemName: isOwned ? "checkmark.seal.fill" : "shippingbox.fill")
                    Text(isOwned ? "Acquired" : "Acquire")
                    Spacer()
                }
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .background(
                    Capsule(style: .continuous)
                        .fill(Color.pink.opacity(isOwned ? 0.55 : 0.95))
                )
            }
            .buttonStyle(.plain)
            .pressable()
            .disabled(isOwned)
        }
    }

    // MARK: - Helpers

    private func bullet(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("•")
                .foregroundColor(.white.opacity(0.8))
            Text(text)
                .foregroundColor(.white.opacity(0.8))
                .font(.system(size: 13))
            Spacer()
        }
    }

    private func handleAcquire() {
        guard !isOwned else { return }
        store.addOne(product)
        store.createOrder(for: product)
    }
}

// MARK: - macOS model sheet

#if os(macOS)
private struct MacModelSheet: NSViewRepresentable {
    let url: URL
    let productName: String

    func makeNSView(context: Context) -> SCNView {
        let scene = try? SCNScene(url: url, options: nil)
        let view = SCNView()
        view.scene = scene
        view.allowsCameraControl = true
        view.backgroundColor = NSColor.black

        // Simple orbit camera
        view.defaultCameraController.interactionMode = .orbitTurntable
        view.defaultCameraController.inertiaEnabled = true

        return view
    }

    func updateNSView(_ nsView: SCNView, context: Context) {
        // No dynamic updates needed.
    }
}
#endif
