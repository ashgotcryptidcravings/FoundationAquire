import SwiftUI

@available(macOS 12.0, iOS 15.0, *)
struct HomeView: View {
    let userEmail: String

    @EnvironmentObject var store: StoreModel

    /// Hidden dev mode toggle (shared with ContentView / Settings / DebugPanel)
    @AppStorage("Aquire_developerUnlocked")
    private var developerUnlocked: Bool = false

    @State private var showSettings: Bool = false
    @State private var selectedProduct: Product?
    @State private var secretTapCount: Int = 0

    // MARK: - Derived data

    /// If no explicit featured product is set, fall back to first visible.
    private var featuredProduct: Product? {
        store.featuredProduct ?? store.visibleProducts.first
    }

    /// Products the user does *not* own yet, used for "Recommended for You".
    private var recommendedProducts: [Product] {
        store.visibleProducts.filter { !store.isAcquired($0) }
    }

    /// Number of items owned, for the header line.
    private var ownedCount: Int {
        store.acquiredProducts.count
    }

    /// Nice display string for the email.
    private var emailDisplay: String {
        userEmail.isEmpty ? "demo@aquire.app" : userEmail
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            AquireBackgroundView()
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 18) {
                topBar
                    .padding(.horizontal, 20)
                    .padding(.top, 18)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 26) {
                        if let featured = featuredProduct {
                            featuredSection(for: featured)
                        }

                        if !recommendedProducts.isEmpty {
                            recommendationsSection
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
        }
        .sheet(item: $selectedProduct) { product in
            #if os(iOS)
            ProductDetailView(product: product)
                .preferredColorScheme(.dark)
            #else
            ProductDetailView(product: product, showsCloseButton: true)
                .frame(minWidth: 620, minHeight: 520)
                .preferredColorScheme(.dark)
            #endif
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .environmentObject(store)
        }
    }

    // MARK: - Sections

    private var topBar: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Featured Device")
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .onTapGesture { handleSecretTap() }   // hidden dev unlock

                Text("Signed in as \(emailDisplay)")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.7))

                Text("Demo account · \(ownedCount) items owned")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()

            IconGlassButton(systemName: "gearshape.fill", size: 28) {
                showSettings = true
            }
        }
    }

    private func featuredSection(for product: Product) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            FeaturedProductCard(
                product: product,
                isOwned: store.isAcquired(product),
                lastOrder: store.lastOrder(for: product),
                onTap: { selectedProduct = product },
                onViewModel: { selectedProduct = product } // same for now; can swap later
            )
        }
    }

    private var recommendationsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recommended for You")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.white)

            Text("Based on your current Foundation collection")
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.65))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(recommendedProducts) { product in
                        RecommendationCard(product: product)
                            .onTapGesture { selectedProduct = product }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }

    // MARK: - Secret dev unlock

    private func handleSecretTap() {
        secretTapCount += 1

        if secretTapCount >= 7 {
            developerUnlocked = true
            secretTapCount = 0

            #if os(iOS)
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            #endif
        }
    }
}

// MARK: - Featured hero card

@available(macOS 12.0, iOS 15.0, *)
private struct FeaturedProductCard: View {
    let product: Product
    let isOwned: Bool
    let lastOrder: Order?
    let onTap: () -> Void
    let onViewModel: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 18) {
                ZStack {
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(Color.black.opacity(0.6))

                    Image(systemName: product.imageSystemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.purple)
                }
                .frame(width: 110, height: 110)

                VStack(alignment: .leading, spacing: 6) {
                    Text(product.category.uppercased())
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.white.opacity(0.7))

                    Text(product.name)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(1)

                    Text(product.description)
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(2)

                    Spacer().frame(height: 4)

                    HStack(spacing: 10) {
                        Text(product.price, format: .currency(code: "USD"))
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)

                        Spacer()

                        if product.modelName != nil {
                            Button(action: onViewModel) {
                                Text("3D MODEL")
                                    .font(.system(size: 11, weight: .bold))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(
                                        Capsule()
                                            .fill(Color.purple.opacity(0.9))
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    if isOwned {
                        HStack(spacing: 6) {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.green)

                            Text("In your collection")
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.75))

                            if let order = lastOrder {
                                Text("· Updated \(order.date, style: .relative)")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white.opacity(0.55))
                            }
                        }
                    }
                }
            }
            .padding(18)
            .liquidGlass(cornerRadius: 26)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Recommendation card

@available(macOS 12.0, iOS 15.0, *)
private struct RecommendationCard: View {
    let product: Product
    @EnvironmentObject private var store: StoreModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.white.opacity(0.05))

                Image(systemName: product.imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.purple)
            }
            .frame(width: 110, height: 80)
            .overlay(alignment: .topTrailing) {
                if product.modelName != nil {
                    Text("3D")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(Capsule().fill(Color.purple.opacity(0.95)))
                        .foregroundColor(.white)
                        .padding(6)
                }
            }

            Text(product.name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)

            Text(product.price, format: .currency(code: "USD"))
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(12)
        .liquidGlass(cornerRadius: 20)
    }
}
