//
//  StorefrontRouter.swift
//  Aquire
//

import Foundation
import SwiftUI

@MainActor
final class StorefrontRouter: ObservableObject {
    @Published var route: StorefrontRoute = .home

    // Optional: present product detail from anywhere via sheet
    @Published var presentedProductKey: String? = nil

    func home() { route = .home }
    func browse() { route = .browse }
    func wishlist() { route = .wishlist }
    func acquired() { route = .acquired }
    func orders() { route = .orders }
    func info() { route = .info }
    func settings() { route = .settings }

    func detail(_ product: Product) {
        presentedProductKey = ProductCatalog.key(for: product)
    }

    func detail(key: String) {
        presentedProductKey = key
    }

    func dismissDetail() {
        presentedProductKey = nil
    }
}
