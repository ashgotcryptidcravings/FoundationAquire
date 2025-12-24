import Foundation

/// Central catalog keyed by the same String IDs stored in StoreModel.
/// Product itself can remain UUID-identifiable for now.
enum ProductCatalog {

    static let catalog: [String: Product] = [
        "foundation_hub": Product(
            name: "Foundation Hub",
            price: 199.0,
            imageSystemName: "sparkles",
            category: "Core",
            description: "Command surface for the Foundation ecosystem.",
            modelName: "foundation_hub"
        ),

        "onyx_module": Product(
            name: "Onyx Module",
            price: 149.0,
            imageSystemName: "cube.transparent",
            category: "Modules",
            description: "Expandable hardware module for future devices.",
            modelName: "onyx_module"
        ),

        "signal_dock": Product(
            name: "Signal Dock",
            price: 89.0,
            imageSystemName: "bolt.horizontal",
            category: "Power",
            description: "Clean desk dock with optimized power routing.",
            modelName: nil
        ),
        // Chipsets (Foundation Silicon)
        "F-CORE A1": Product(
            name: "F-CORE A1",
            price: 249.00,
            imageSystemName: "cpu",
            category: "Chipsets",
            description: "Foundation-grade compute core for embedded builds and dock systems.",
            modelName: "FCORE_A1"
        ),
        "ONYX Neural Tile": Product(
            name: "ONYX Neural Tile",
            price: 399.00,
            imageSystemName: "brain",
            category: "Chipsets",
            description: "Low-latency neural processing tile for Onyx devices.",
            modelName: "OnyxNeuralTile"
        ),
        "Signal ASIC": Product(
            name: "Signal ASIC",
            price: 179.00,
            imageSystemName: "wave.3.right",
            category: "Chipsets",
            description: "Signal routing + timing controller for high-integrity links.",
            modelName: nil
        )
    ]

    static var all: [Product] {
        catalog
            .sorted(by: { $0.key < $1.key })
            .map { $0.value }
    }

    static func product(for key: String) -> Product? {
        catalog[key]
    }

    static func products(for keys: [String]) -> [Product] {
        keys.compactMap { catalog[$0] }
    }

    /// Reverse lookup: find the catalog key for a product.
    /// Uses stable matching by name+category+price+icon to avoid UUID mismatch.
    static func key(for product: Product) -> String? {
        catalog.first(where: { _, p in
            p.name == product.name &&
            p.category == product.category &&
            p.price == product.price &&
            p.imageSystemName == product.imageSystemName
        })?.key
    }
}
extension ProductCatalog {
    static var categories: [String] {
        Array(Set(catalog.values.map { $0.category }))
            .sorted()
    }

    static func products(in category: String) -> [Product] {
        all.filter { $0.category == category }
    }

    static var featuredKeys: [String] = [
        "foundation_hub",
        "onyx_module",
        "fcore_a1"
    ]

    static var featured: [Product] {
        products(for: featuredKeys)
    }

    static var chipsets: [Product] {
        products(in: "Chipsets")
    }
}