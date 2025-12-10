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

    // MARK: - Admin metadata

    struct ProductAdminMetadata: Identifiable {
        let id: UUID          // product.id
        var isFeatured: Bool
        var isHidden: Bool
        var badge: String?
    }

    /// product.id -> admin metadata
    @Published private(set) var adminMetadata: [UUID: ProductAdminMetadata] = [:]

    // MARK: - Internal admin helpers

    /// Ensure we always have metadata for a product.
    private func metadata(for product: Product) -> ProductAdminMetadata {
        if let existing = adminMetadata[product.id] {
            return existing
        } else {
            let meta = ProductAdminMetadata(
                id: product.id,
                isFeatured: false,
                isHidden: false,
                badge: nil
            )
            adminMetadata[product.id] = meta
            return meta
        }
    }

    // MARK: - Admin query helpers

    func isHidden(_ product: Product) -> Bool {
        metadata(for: product).isHidden
    }

    func badge(for product: Product) -> String? {
        metadata(for: product).badge
    }

    /// Currently featured product (if any), falling back to first product.
    var featuredProduct: Product? {
        if let featured = products.first(where: { adminMetadata[$0.id]?.isFeatured == true }) {
            return featured
        }
        return products.first
    }

    /// Products that should show up in Browse, recommendations, etc.
    var visibleProducts: [Product] {
        products.filter { !isHidden($0) }
    }

    // MARK: - Admin mutations

    func setFeatured(_ product: Product?) {
        // Clear previous featured flag
        for id in adminMetadata.keys {
            adminMetadata[id]?.isFeatured = false
        }

        // If nil, leave everything unfeatured
        guard let product = product else { return }

        var meta = metadata(for: product)
        meta.isFeatured = true
        adminMetadata[product.id] = meta
    }

    func setHidden(_ isHidden: Bool, for product: Product) {
        var meta = metadata(for: product)
        meta.isHidden = isHidden
        adminMetadata[product.id] = meta
    }

    func setBadge(_ badge: String?, for product: Product) {
        var meta = metadata(for: product)
        let trimmed = badge?.trimmingCharacters(in: .whitespacesAndNewlines)
        meta.badge = (trimmed?.isEmpty == false) ? trimmed : nil
        adminMetadata[product.id] = meta
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
        adminMetadata.removeAll()
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

    // MARK: - XP (deprecated)

    /// XP/level system is currently disabled.
    /// Keeping this stub so existing calls compile without mutating state.
    private func awardXP(_ amount: Int) {
        // no-op
    }
}
