import SwiftUI
#if os(macOS)
import AppKit
import SceneKit
#endif

// MARK: - Product Detail + Checkout

struct ProductDetailView: View {
    let product: Product
    var showsCloseButton: Bool = false      // for macOS sheets

    @EnvironmentObject var store: StoreModel
    @Environment(\.dismiss) private var dismiss

    @State private var showingCheckout = false
    @State private var showingModel = false
    @State private var isUpdatingFirmware = false

    private var hasModel: Bool { product.modelName != nil }
    private var isOwned: Bool { store.isAcquired(product) }
    private var isWishlisted: Bool { store.isWishlisted(product) }

    var body: some View {
        ZStack {
            AquireBackgroundView()

            VStack(spacing: 0) {
                // Optional close button for sheet-style usage on macOS
                if showsCloseButton {
                    HStack {
                        IconGlassButton(systemName: "xmark") {
                            dismiss()
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                    Divider().background(Color.white.opacity(0.1))
                }

                ScrollView {
                    VStack(spacing: 24) {
                        // Hero card
                        ProductCard(product: product)
                            .padding(.top, showsCloseButton ? 24 : 40)

                        // Category + description
                        VStack(alignment: .leading, spacing: 12) {
                            Text(product.category.uppercased())
                                .font(.caption)
                                .foregroundColor(.purple)

                            Text(product.description)
                                .foregroundColor(Color.white.opacity(0.9))
                                .font(.system(size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        // Lore compatibility
                        compatibilitySection

                        // Firmware only if owned
                        if isOwned {
                            firmwareSection
                        }

                        // Actions
                        actionButtonsSection

                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                    .frame(maxWidth: 780)           // content column width
                    .frame(maxWidth: .infinity)     // center in sheet
                }
            }
        }
        .navigationTitle(product.name)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .sheet(isPresented: $showingCheckout) {
            CheckoutView(product: product)
                .environmentObject(store)
        }
        #if os(iOS)
        .sheet(isPresented: $showingModel) {
            if let modelName = product.modelName,
               let url = Bundle.main.url(forResource: modelName, withExtension: "usdz") {
                ModelQuickLookView(url: url)
            } else {
                ZStack {
                    AquireBackgroundView()
                    Text("3D model not found.")
                        .foregroundColor(.white)
                }
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

    // MARK: - Sections

    private var compatibilitySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Compatibility")
                .font(.headline)
                .foregroundColor(Color.white)

            Text("• FoundationOS 2.0 and later")
                .foregroundColor(Color.white.opacity(0.85))
                .font(.system(size: 13))

            let bullet: String = {
                switch product.category.lowercased() {
                case "devices":
                    return "• Pairs with OnyxGlove, OnyxSuit, Foundation Dock"
                case "wearables":
                    return "• Requires a linked Foundation device"
                case "docking":
                    return "• Supports up to 4 Foundation devices concurrently"
                default:
                    return "• Integrated into the wider Foundation ecosystem"
                }
            }()

            Text(bullet)
                .foregroundColor(Color.white.opacity(0.8))
                .font(.system(size: 13))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var firmwareSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Firmware")
                .font(.headline)
                .foregroundColor(Color.white)

            Text("Version \(store.currentFirmware(for: product))")
                .foregroundColor(Color.white.opacity(0.85))
                .font(.system(size: 13))

            Button(action: startFirmwareUpdate) {
                HStack {
                    if isUpdatingFirmware {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(0.8)
                    }
                    Text(isUpdatingFirmware ? "Updating…" : "Check for Update")
                }
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(
                    Capsule().fill(Color.purple.opacity(0.2))
                )
                .foregroundColor(.purple)
            }
            .disabled(isUpdatingFirmware)
            .pressable()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var actionButtonsSection: some View {
        VStack(spacing: 12) {
            // 3D Model button (only if this product has a model)
            if hasModel {
                Button(action: handleView3D) {
                    HStack {
                        Image(systemName: "arkit")
                        Text("View in 3D")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            colors: [.purple, Color(red: 0.8, green: 0.4, blue: 1.0)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .clipShape(Capsule())
                    )
                    .foregroundColor(.white)
                }
                .pressable()
            }

            // Wishlist button
            Button(action: { store.toggleWishlist(for: product) }) {
                HStack {
                    Image(systemName: isWishlisted ? "star.fill" : "star")
                    Text(isWishlisted ? "In Wishlist" : "Add to Wishlist")
                }
                .font(.system(size: 15, weight: .semibold))
                .padding(.horizontal, 26)
                .padding(.vertical, 10)
                .background(
                    Capsule().fill(Color.white.opacity(0.06))
                )
                .foregroundColor(Color.white)
            }
            .pressable()

            // Acquire / checkout button
            Button(action: {
                showingCheckout = true
            }) {
                Text("Acquire")
                    .font(.system(size: 17, weight: .semibold))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(
                        Capsule().fill(Color.purple)
                    )
                    .foregroundColor(Color.white)
            }
            .pressable()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Actions

    private func handleView3D() {
        guard hasModel else { return }
        showingModel = true
    }

    private func startFirmwareUpdate() {
        guard !isUpdatingFirmware else { return }
        isUpdatingFirmware = true

        // Fake delay to "install" firmware
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            store.updateFirmware(for: product)
            isUpdatingFirmware = false
        }
    }
}

// MARK: - Checkout

struct CheckoutView: View {
    let product: Product
    @EnvironmentObject var store: StoreModel
    @Environment(\.dismiss) private var dismiss

    private let taxRate: Double = 0.0725
    private let fee: Double = 4.99

    private var subtotal: Double { product.price }
    private var tax: Double { subtotal * taxRate }
    private var total: Double { subtotal + tax + fee }

    #if os(iOS)
    @State private var showApplePayDemoAlert = false
    #endif

    var body: some View {
        ZStack {
            // Dimmed backdrop
            Color.black.opacity(0.6).ignoresSafeArea()

            // Centered card
            VStack {
                VStack(spacing: 24) {
                    // Header
                    HStack {
                        Image(systemName: "lock.shield.fill")
                            .foregroundColor(.purple)
                        Text("Secure Checkout")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }

                    // Payment method
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Payment method")
                            .font(.caption)
                            .foregroundColor(Color.white.opacity(0.7))

                        HStack(spacing: 8) {
                            Image(systemName: "creditcard.fill")
                            Text("Foundation Card · •••• 4242")
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                    }

                    #if os(iOS)
                    // Fake Apple Pay button – visual only
                    ApplePayButton {
                        showApplePayDemoAlert = true
                    }
                    .frame(height: 44)
                    .padding(.top, 2)
                    #endif

                    // Line items
                    VStack(spacing: 16) {
                        HStack {
                            Text(product.name)
                                .foregroundColor(Color.white)
                            Spacer()
                            Text(subtotal, format: .currency(code: "USD"))
                                .foregroundColor(Color.white)
                        }

                        Divider().background(Color.white.opacity(0.2))

                        HStack {
                            Text("Estimated tax")
                                .foregroundColor(Color.white.opacity(0.85))
                            Spacer()
                            Text(tax, format: .currency(code: "USD"))
                                .foregroundColor(Color.white.opacity(0.85))
                        }

                        HStack {
                            Text("Fees")
                                .foregroundColor(Color.white.opacity(0.85))
                            Spacer()
                            Text(fee, format: .currency(code: "USD"))
                                .foregroundColor(Color.white.opacity(0.85))
                        }

                        Divider().background(Color.white.opacity(0.2))

                        HStack {
                            Text("Total")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.white)
                            Spacer()
                            Text(total, format: .currency(code: "USD"))
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding()
                    .frostCard(cornerRadius: 20)

                    // Confirm button (gradient)
                    Button(action: {
                        store.addOne(product)
                        store.createOrder(for: product)
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "checkmark.shield.fill")
                            Text("Confirm Purchase")
                        }
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.horizontal, 32)
                        .padding(.vertical, 12)
                        .background(
                            LinearGradient(
                                colors: [.purple, Color(red: 0.8, green: 0.4, blue: 1.0)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .clipShape(Capsule())
                        )
                        .foregroundColor(.white)
                    }
                    .pressable()

                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color.white.opacity(0.7))
                    .padding(.top, 2)
                }
                .padding(22)
                .background(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .stroke(Color.white.opacity(0.08), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.6), radius: 30, x: 0, y: 18)
                )
                .frame(maxWidth: 360)

                Spacer(minLength: 0)
            }
            .padding(.top, 40)
        }
        #if os(iOS)
        .alert("Apple Pay (demo)",
               isPresented: $showApplePayDemoAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("In a production build, Apple Pay would be presented here.")
        }
        #endif
    }
}

// MARK: - macOS 3D Viewer

#if os(macOS)
struct MacModelSheet: View {
    let url: URL
    let productName: String

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Dimmed backdrop behind the 3D pod
            Color.black.opacity(0.6).ignoresSafeArea()

            VStack {
                Spacer(minLength: 0)

                VStack(spacing: 16) {
                    // Header with centered title + balanced X
                    HStack {
                        IconGlassButton(systemName: "xmark") {
                            dismiss()
                        }

                        Spacer()

                        Text(productName)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)

                        Spacer()

                        Color.clear
                            .frame(width: 28, height: 28)
                    }
                    .padding(.horizontal)

                    MacModelView(url: url)
                        .frame(minWidth: 420, minHeight: 420)
                        .cornerRadius(24)
                        .padding(.horizontal)
                        .shadow(radius: 20)

                    Text("Click and drag to orbit. Scroll to zoom.")
                        .font(.system(size: 11))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.bottom, 12)
                }
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 26, style: .continuous)
                                .stroke(Color.white.opacity(0.08), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.6), radius: 28, x: 0, y: 18)
                )
                .padding(.horizontal, 48)

                Spacer(minLength: 0)
            }
        }
    }
}

struct MacModelView: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> SCNView {
        let view = SCNView()

        view.backgroundColor = .clear
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true

        if let scene = try? SCNScene(url: url, options: nil) {
            view.scene = scene
        }

        // Nice, simple orbit camera
        view.defaultCameraController.interactionMode = .orbitTurntable
        view.defaultCameraController.inertiaEnabled = true

        return view
    }

    func updateNSView(_ nsView: SCNView, context: Context) {
        // No dynamic updates needed right now.
    }
}
#endif
