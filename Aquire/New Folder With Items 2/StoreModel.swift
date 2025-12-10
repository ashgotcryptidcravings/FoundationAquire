import Foundation
import SwiftUI

@MainActor
final class StoreModel: ObservableObject {
    /// product.id -> quantity
    @Published private(set) var acquired: [UUID: Int] = [:]
    @Published private(set) var orders: [Order] = []

    /// IDs of wishlisted products
    @Published private(set) var wishlist: Set<UUID> = []

    /// product.id -> firmware version (starting at 1 by default)
    @Published private(set) var firmwareVersions: [UUID: Int] = [:]

    /// Simple gamification
    @Published private(set) var xp: Int = 0

    /// Level is derived from XP (100 xp per level)
    var level: Int {
        max(1, xp / 100 + 1)
    }

    // MARK: - Query helpers

    func quantity(for product: Product) -> Int {
        acquired[product.id] ?? 0
    }

    func isAcquired(_ product: Product) -> Bool {
        quantity(for: product) > 0
    }

    func isWishlisted(_ product: Product) -> Bool {
        wishlist.contains(product.id)
    }

    func currentFirmware(for product: Product) -> Int {
        firmwareVersions[product.id, default: 1]
    }

    // MARK: - Mutations

    func addOne(_ product: Product) {
        acquired[product.id, default: 0] += 1
        awardXP(10) // buying something feels rewarding
    }

    func removeAll(_ product: Product) {
        acquired[product.id] = nil
    }

    func toggleWishlist(for product: Product) {
        if wishlist.contains(product.id) {
            wishlist.remove(product.id)
        } else {
            wishlist.insert(product.id)
            awardXP(2) // small hit for curating wishlist
        }
    }

    func updateFirmware(for product: Product) {
        let current = firmwareVersions[product.id, default: 1]
        firmwareVersions[product.id] = current + 1
        awardXP(5)
    }

    func resetAll() {
        acquired.removeAll()
        orders.removeAll()
        wishlist.removeAll()
        firmwareVersions.removeAll()
        xp = 0
    }

    // MARK: - Derived collections

    /// Only look up products we actually own, using the fast dictionary.
    var acquiredProducts: [Product] {
        acquired.keys
            .compactMap { productsByID[$0] }
            .sorted { $0.name < $1.name }
    }

    var wishlistProducts: [Product] {
        wishlist
            .compactMap { productsByID[$0] }
            .sorted { $0.name < $1.name }
    }

    var totalSpent: Double {
        acquired.reduce(0) { partial, entry in
            let (id, qty) = entry
            guard let product = productsByID[id] else { return partial }
            return partial + product.price * Double(qty)
        }
    }

    // MARK: - Orders

    func createOrder(for product: Product) {
        let order = Order(product: product, date: Date(), status: .processing)
        orders.insert(order, at: 0)
        awardXP(15)
    }

    func lastOrder(for product: Product) -> Order? {
        orders.first(where: { $0.product.id == product.id })
    }

    // MARK: - XP

    private func awardXP(_ amount: Int) {
        xp += max(0, amount)
    }
}
