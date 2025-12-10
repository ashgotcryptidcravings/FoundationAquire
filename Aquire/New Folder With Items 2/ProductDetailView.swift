import SwiftUI
#if os(macOS)
import AppKit
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
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // Optional close button for sheet-style usage on macOS
                if showsCloseButton {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.white.opacity(0.8))
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
                    Color.black.ignoresSafeArea()
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var actionButtonsSection: some View {
        VStack(spacing: 12) {
            if hasModel {
                Button(action: handleView3D) {
                    HStack(spacing: 8) {
                        Image(systemName: "view.3d")
                        Text("View in 3D")
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.horizontal, 26)
                    .padding(.vertical, 10)
                    .background(
                        Capsule().stroke(Color.purple, lineWidth: 1.5)
                    )
                    .foregroundColor(.purple)
                }
            }

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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: - Actions

    private func handleView3D() {
        #if os(iOS)
        showingModel = true
        #elseif os(macOS)
        if let modelName = product.modelName,
           let url = Bundle.main.url(forResource: modelName, withExtension: "usdz") {
            NSWorkspace.shared.activateFileViewerSelecting([url])
        }
        #endif
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
            Color.black.ignoresSafeArea()

            VStack(spacing: 24) {
                HStack {
                    Image(systemName: "lock.shield.fill")
                        .foregroundColor(.purple)
                    Text("Secure Checkout")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 24)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Payment method")
                        .font(.caption)
                        .foregroundColor(Color.white.opacity(0.7))

                    HStack {
                        Image(systemName: "creditcard.fill")
                        Text("Foundation Card · •••• 4242")
                    }
                    .foregroundColor(Color.white)
                    .font(.system(size: 14))
                }

                #if os(iOS)
                // Fake Apple Pay button – visual only
                ApplePayButton {
                    showApplePayDemoAlert = true
                }
                .frame(height: 44)
                .padding(.top, 4)
                #endif

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
                            .foregroundColor(Color.white.opacity(0.8))
                        Spacer()
                        Text(tax, format: .currency(code: "USD"))
                            .foregroundColor(Color.white.opacity(0.8))
                    }

                    HStack {
                        Text("Fees")
                            .foregroundColor(Color.white.opacity(0.8))
                        Spacer()
                        Text(fee, format: .currency(code: "USD"))
                            .foregroundColor(Color.white.opacity(0.8))
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
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color(red: 0.1, green: 0.1, blue: 0.1))
                )

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
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(Capsule().fill(Color.purple))
                    .foregroundColor(Color.white)
                }

                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(Color.white.opacity(0.7))
                .padding(.top, 4)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
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
