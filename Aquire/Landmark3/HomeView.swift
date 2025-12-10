import SwiftUI

@available(macOS 12.0, iOS 15.0, *)
struct HomeView: View {
    let userEmail: String

    @EnvironmentObject var store: StoreModel
    @AppStorage("Aquire_developerUnlocked") private var developerUnlocked: Bool = false

    @State private var showSettings = false
    @State private var secretTapCount = 0
    @State private var selectedProduct: Product?
    @State private var bgPulse: CGFloat = 0.0

    // Products user does NOT own yet (and are visible)
    private var recommendedProducts: [Product] {
        let ownedIDs = Set(store.acquiredProducts.map { $0.id })
        return store.visibleProducts.filter { !ownedIDs.contains($0.id) }
    }

    var body: some View {
        ZStack {
            AquireBackgroundView()
                .opacity(0.95 + 0.05 * bgPulse)

            VStack(alignment: .leading, spacing: 16) {
                // Header row
                HStack(alignment: .top) {
                    header
                    Spacer()
                }
                .padding(.horizontal, 28)
                .padding(.top, 32)

                // Main content
                ScrollView {
                    VStack(spacing: 28) {
                        featuredCardSection

                        if !recommendedProducts.isEmpty {
                            recommendationsSection
                        }
                    }
                    .padding(.bottom, 32)
                }
                .sheet(item: $selectedProduct) { product in
                    ProductDetailView(product: product, showsCloseButton: true)
                        .environmentObject(store)
                }
            }
        }
        .onAppear {
            withAnimation(AquireMotion.ambient) {
                bgPulse = 1.0
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .environmentObject(store)
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Featured Device")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.white)
                .onTapGesture {
                    handleSecretTap()
                }

            Text("Signed in as \(userEmail)")
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.6))

            Text("Demo account · \(store.acquiredProducts.count) items owned")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.white.opacity(0.8))
        }
    }

    // MARK: - Sections

    private var featuredCardSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today’s Highlight")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 24)

            if let featured = store.featuredProduct {
                Button {
                    selectedProduct = featured
                } label: {
                    FeaturedHeroCard(product: featured)
                        .padding(.horizontal, 24)
                }
                .pressable()
            } else {
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 28))
                            .foregroundColor(.white.opacity(0.4))

                        Text("No Featured Device Selected")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.vertical, 40)
                    Spacer()
                }
            }
        }
    }

    private var recommendationsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recommended for You")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 24)

            Text("Based on your current Foundation collection")
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.6))
                .padding(.horizontal, 24)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(recommendedProducts) { product in
                        Button {
                            selectedProduct = product
                        } label: {
                            SmallRecommendationCard(product: product)
                        }
                        .pressable()
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 4)
            }
        }
    }

    // MARK: - Secret Gesture

    private func handleSecretTap() {
        secretTapCount += 1

        if secretTapCount >= 7 {
            secretTapCount = 0
            developerUnlocked = true
            showSettings = true
        }
    }
}

// MARK: - Featured Hero Card

struct FeaturedHeroCard: View {
    let product: Product
    @EnvironmentObject var store: StoreModel

    private var hasModel: Bool { product.modelName != nil }

    var body: some View {
        HStack(spacing: 18) {
            // Icon + main info
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.black.opacity(0.6))

                    Image(systemName: product.imageSystemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.purple)
                }
                .frame(width: 96, height: 96)

                VStack(alignment: .leading, spacing: 6) {
                    Text(product.category.uppercased())
                        .font(.caption)
                        .foregroundColor(.purple.opacity(0.9))

                    Text(product.name)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)

                    Text(product.description)
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(2)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 10) {
                Text(product.price, format: .currency(code: "USD"))
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                VStack(alignment: .trailing, spacing: 4) {
                    if hasModel {
                        Text("3D MODEL")
                            .font(.caption2)
                            .foregroundColor(.purple)
                            .frostedPill(tint: .purple)
                    }

                    if store.isAcquired(product) {
                        Text("OWNED")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .frostedPill(tint: .purple)
                    }
                }
            }
        }
        .padding(18)
        .liquidGlass(cornerRadius: 26)
        .frame(maxWidth: 640)
    }
}

// MARK: - Recommendation Card

struct SmallRecommendationCard: View {
    let product: Product
    @EnvironmentObject var store: StoreModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Image(systemName: product.imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.purple)

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    if product.modelName != nil {
                        Text("3D")
                            .font(.caption2)
                            .foregroundColor(.purple)
                            .frostedPill(tint: .purple)
                    }

                    if store.isAcquired(product) {
                        Text("Owned")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .frostedPill(tint: .purple)
                    }
                }
            }

            Text(product.name)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)

            Text(product.price, format: .currency(code: "USD"))
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.75))
        }
        .padding(10)
        .frame(width: 160, alignment: .leading)
        .frostCard(cornerRadius: 14)
    }
}

// MARK: - Product Card (used in detail view)

struct ProductCard: View {
    let product: Product
    @EnvironmentObject var store: StoreModel

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: product.imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.purple)

                Spacer()

                if store.isAcquired(product) {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Owned")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .frostedPill(tint: .purple)

                        Text("×\(store.quantity(for: product))")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                Text(product.price, format: .currency(code: "USD"))
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.85))
            }

            Text(product.description)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.6))
                .lineLimit(3)
        }
        .padding(16)
        .liquidGlass(cornerRadius: 18)
        .frame(maxWidth: 360)
    }
}
