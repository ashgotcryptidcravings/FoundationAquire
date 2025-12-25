import SwiftUI

struct AcquiredView: View {
    @EnvironmentObject private var store: StoreModel

    private var acquiredPairs: [(id: String, qty: Int)] {
        store.acquired
            .map { (id: $0.key, qty: $0.value) }
            .sorted { $0.id < $1.id }
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                AquireHeader(title: "Acquired", subtitle: "Products you own and can manage.")

                if store.acquired.isEmpty {
                    AquireSurface {
                        EmptyStateCard(
                            icon: "checkmark.seal",
                            title: "Nothing acquired yet",
                            message: "When you purchase something, it’ll appear here with firmware and setup tools."
                        )
                    }
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(acquiredPairs, id: \.id) { item in
                            let product = ProductCatalog.product(for: item.id) ?? Product(
                                name: item.id,
                                price: 0,
                                imageSystemName: "cube.transparent",
                                category: "Unknown",
                                description: "Catalog entry not found yet.",
                                modelName: nil
                            )

                            AquireProductRow(product: product, trailingText: "x\(item.qty)")
                        }
                    }
                }
            }
            .padding(18)
        }
        .aquireBackground()
    }
}
