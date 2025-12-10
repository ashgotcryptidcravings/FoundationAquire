import SwiftUI

@available(macOS 12.0, iOS 15.0, *)
struct HomeView: View {
    let product: Product
    let userEmail: String

    @EnvironmentObject var store: StoreModel

    @State private var showSettings = false
    @State private var developerUnlocked = false
    @State private var secretTapCount = 0

    // The product we’re currently “zooming into” from Home
    @State private var selectedProduct: Product?

    // Products user does NOT own yet
    private var recommendedProducts: [Product] {
        let ownedIDs = Set(store.acquiredProducts.map { $0.id })
        return products.filter { !ownedIDs.contains($0.id) }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

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
                // Product detail sheet triggered from taps on cards
                .sheet(item: $selectedProduct) { product in
                    ProductDetailView(product: product, showsCloseButton: true)
                        .environmentObject(store)
                }
            }
        }
        // Settings sheet from secret taps
        .sheet(isPresented: $showSettings) {
            SettingsView(developerUnlocked: developerUnlocked)
                .environmentObject(store)
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Featured Device")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.white)
                .onTapGesture {
                    handleSecretTap()
                }

            Text("Signed in as \(userEmail)")
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.6))

            HStack(spacing: 6) {
                Text("Level \(store.level)")
                    .font(.system(size: 11, weight: .semibold))
                Text("·")
                Text("\(store.xp) XP")
            }
            .foregroundColor(.purple.opacity(0.9))
            .font(.system(size: 11))
        }
    }

    // MARK: - Sections

    private var featuredCardSection: some View {
        HStack {
            Spacer()
            Button {
                selectedProduct = product
            } label: {
                ProductCard(product: product)
                    .frame(maxWidth: 420)
            }
            .buttonStyle(PlainButtonStyle())
            Spacer()
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
                        .buttonStyle(PlainButtonStyle())
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

// MARK: - Recommendation Card (lightweight)

struct SmallRecommendationCard: View {
    let product: Product
    @EnvironmentObject var store: StoreModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: product.imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.purple)

                Spacer()

                if store.isAcquired(product) {
                    Text("Owned")
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(
                            Capsule().fill(Color.purple.opacity(0.9))
                        )
                        .foregroundColor(.white)
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
        .frame(width: 140, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(red: 0.09, green: 0.09, blue: 0.09))
        )
    }
}

// MARK: - Product Card (lighter, Mac-friendly)

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
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule().fill(Color.purple.opacity(0.9))
                            )
                            .foregroundColor(.white)

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
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(red: 0.08, green: 0.08, blue: 0.08))
        )
        .frame(maxWidth: 360)
    }
}
