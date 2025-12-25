import SwiftUI

struct BrowseView: View {
    let products: [Product]
    @State private var searchText: String = ""

    private var filtered: [Product] {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return products }
        return products.filter {
            $0.name.lowercased().contains(q) ||
            $0.category.lowercased().contains(q)
        }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 14) {

                AquireHeroCard(
                    title: "Catalog",
                    subtitle: "Browse every Foundation product in one place.",
                    systemImage: "square.grid.2x2"
                )

                #if os(iOS)
                TextField("Search", text: $searchText)
                    .textFieldStyle(.plain)
                    .padding(14)
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .foregroundColor(.white)
                #endif

                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ], spacing: 12) {
                    // Use stable name-based id to reduce churn
                    ForEach(filtered, id: \.name) { p in
                        CatalogCard(product: p)
                    }
                }
            }
            .padding(16)
        }
        .background(AquireBackdrop().ignoresSafeArea())
    }
}

private struct CatalogCard: View {
    let product: Product

    var body: some View {
        AquireSurface(cornerRadius: 26, padding: 16) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: product.imageSystemName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white.opacity(0.92))
                    Spacer()
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.75))
                }

                Text(product.name)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(product.category)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.65))
            }
        }
    }
}
