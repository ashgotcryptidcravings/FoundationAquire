import SwiftUI

struct BrowseView: View {
    let products: [Product]
    @EnvironmentObject var store: StoreModel

    @State private var searchText: String = ""
    @State private var selectedProduct: Product?   // macOS sheet

    // 2-column grid
    private let columns = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]

    private var filteredProducts: [Product] {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return products }

        let query = trimmed.lowercased()
        return products.filter {
            $0.name.lowercased().contains(query) ||
            $0.category.lowercased().contains(query)
        }
    }

    var body: some View {
        #if os(iOS)
        iOSBody
        #else
        macOSBody
            .sheet(item: $selectedProduct) { product in
                ProductDetailView(product: product, showsCloseButton: true)
                    .environmentObject(store)
            }
        #endif
    }

    // MARK: - iOS

    private var iOSBody: some View {
        NavigationView {
            ZStack {
                AquireBackgroundView()
                iOSGridContent
            }
            .navigationTitle("Browse")
            .searchable(
                text: $searchText,
                prompt: "Search devices, wearables…"
            )
        }
    }

    @ViewBuilder
    private var iOSGridContent: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(filteredProducts) { product in
                    NavigationLink(
                        destination: ProductDetailView(product: product)
                    ) {
                        BrowseCard(product: product)
                    }
                    .buttonStyle(PressableScaleStyle())
                }
            }
            .padding(24)
            .frame(maxWidth: 800)          // keep it nicely centered
            .frame(maxWidth: .infinity)    // center in window
        }
    }

    // MARK: - macOS

    private var macOSBody: some View {
        ZStack {
            AquireBackgroundView()

            VStack(spacing: 16) {
                // Header
                HStack {
                    Text("Browse")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)

                // Search bar
                HStack {
                    TextField("Search devices, wearables…", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(8)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    Spacer().frame(width: 24)
                }
                .padding(.horizontal, 24)

                macOSGridContent

                Spacer(minLength: 0)
            }
        }
    }

    @ViewBuilder
    private var macOSGridContent: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(filteredProducts) { product in
                    Button {
                        selectedProduct = product
                    } label: {
                        BrowseCard(product: product)
                    }
                    .pressable()
                }
            }
            .padding(24)
            .frame(maxWidth: 900)
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Card

struct BrowseCard: View {
    let product: Product
    @EnvironmentObject var store: StoreModel

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white.opacity(0.05))

                // Icon centered
                Image(systemName: product.imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.purple)
            }
            .frame(height: 120)
            // Badges only, stuck to the top-right
            .overlay(alignment: .topTrailing) {
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
                .padding(6)
            }

            Text(product.name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Text(product.price, format: .currency(code: "USD"))
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(10)
        .liquidGlass(cornerRadius: 20)
    }
}
