//
//  StorefrontShellView.swift
//  Aquire
//

import SwiftUI

struct StorefrontShellView: View {
    @EnvironmentObject private var store: StoreModel
    @EnvironmentObject private var router: StorefrontRouter

    var body: some View {
        TabView(selection: $router.route) {

            HomeView()
                .tag(StorefrontRoute.home)
                .tabItem { Label("Home", systemImage: "house") }

            BrowseView(products: ProductCatalog.all)
                .tag(StorefrontRoute.browse)
                .tabItem { Label("Browse", systemImage: "square.grid.2x2") }

            if !store.wishlist.isEmpty {
                WishlistView()
                    .tag(StorefrontRoute.wishlist)
                    .tabItem { Label("Wishlist", systemImage: "bookmark") }
            }

            if !store.acquired.isEmpty {
                AcquiredView()
                    .tag(StorefrontRoute.acquired)
                    .tabItem { Label("Acquired", systemImage: "checkmark.seal") }
            }

            if !store.orders.isEmpty {
                OrdersView()
                    .tag(StorefrontRoute.orders)
                    .tabItem { Label("Orders", systemImage: "shippingbox") }
            }

            SettingsView()
                .tag(StorefrontRoute.settings)
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
}
