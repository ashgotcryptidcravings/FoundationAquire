//
//  StorefrontDetailView.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import SwiftUI

struct StorefrontDetailView: View {
    let route: StorefrontRoute

    var body: some View {
        Group {
            switch route {
            case .home:
                HomeView()

            case .browse:
                BrowseView(products: Product.sampleProducts)

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
        .aquireBackground()
    }
}