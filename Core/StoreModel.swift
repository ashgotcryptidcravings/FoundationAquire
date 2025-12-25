//
//  StoreModel.swift
//  Aquire
//

import Foundation
import SwiftUI

@MainActor
final class StoreModel: ObservableObject {

    // MARK: - State

    @Published var wishlist: Set<String> = []
    @Published var acquired: [String: Int] = [:]
    @Published var orders: [Order] = []

    init() {}

    // MARK: - Wishlist

    func addToWishlist(_ key: String) {
        wishlist.insert(key)
    }

    func removeFromWishlist(_ key: String) {
        wishlist.remove(key)
    }

    func toggleWishlist(_ key: String) {
        if wishlist.contains(key) {
            wishlist.remove(key)
        } else {
            wishlist.insert(key)
        }
    }

    func isWishlisted(_ key: String) -> Bool {
        wishlist.contains(key)
    }

    // MARK: - Purchasing

    func placeOrder(for key: String) {
        acquired[key, default: 0] += 1

        if let product = ProductCatalog.product(for: key) {
            let order = Order(product: product, date: Date(), status: .processing)
            orders.insert(order, at: 0)
        }
    }

    func acquiredCount(for key: String) -> Int {
        acquired[key, default: 0]
    }
}
