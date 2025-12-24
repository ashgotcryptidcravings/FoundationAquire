import SwiftUI

struct WishlistView: View {
    @EnvironmentObject private var store: StoreModel

    private var wishlistedProducts: [Product] {
        ProductCatalog.products(for: Array(store.wishlist).sorted())
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                AquireHeader(title: "Wishlist", subtitle: "Saved items you want to acquire.")

                if store.wishlist.isEmpty {
                    AquireSurface {
                        EmptyStateCard(
                            icon: "bookmark",
                            title: "Nothing saved yet",
                            message: "Browse the catalog and tap the bookmark to build your wishlist."
                        )
                    }
                } else if wishlistedProducts.isEmpty {
                    AquireSurface {
                        EmptyStateCard(
                            icon: "bookmark.slash",
                            title: "Unknown items",
                            message: "Your wishlist contains IDs that aren’t in the catalog yet."
                        )
                    }
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(wishlistedProducts, id: \.name) { product in
                            AquireProductRow(product: product)
                        }
                    }
                }
            }
            .padding(18)
        }
        .aquireBackground()
    }
}
