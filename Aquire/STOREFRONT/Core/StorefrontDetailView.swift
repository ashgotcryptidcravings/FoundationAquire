import SwiftUI

/// Lightweight “detail hub” used when the shell wants a single place
/// to render the currently-selected route.
/// This file exists so we can keep StorefrontShellView clean.
struct StorefrontDetailView: View {
    @EnvironmentObject private var router: StorefrontRouter

    var body: some View {
        Group {
            switch router.route {
            case .home:
                HomeView()

            case .browse:
                BrowseView(products: ProductCatalog.all)

            case .wishlist:
                WishlistView()

            case .acquired:
                AcquiredView()

            case .orders:
                OrdersView()

            case .info:
                InfoView()

            case .settings:
                SettingsView()
            }
        }
    }
}
