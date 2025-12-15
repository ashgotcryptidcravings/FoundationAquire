//
//  ProductCatalog.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import Foundation

/// Temporary central catalog for Alpha2.0 framework.
/// Later this can be replaced with remote sync / admin-fed data.
enum ProductCatalog {

    static var all: [Product] {
        // If your Product has an initializer matching these fields, this compiles.
        // If your Product struct differs, paste Product definition and I’ll match it exactly.
        [
            Product(
                name: "Foundation Hub",
                price: 199.0,
                imageSystemName: "sparkles",
                category: "Core",
                description: "Command surface for the Foundation ecosystem.",
                modelName: "foundation_hub"
            ),
            Product(
                name: "Onyx Module",
                price: 149.0,
                imageSystemName: "cube.transparent",
                category: "Modules",
                description: "Expandable hardware module for future devices.",
                modelName: "onyx_module"
            ),
            Product(
                name: "Signal Dock",
                price: 89.0,
                imageSystemName: "bolt.horizontal",
                category: "Power",
                description: "Clean desk dock with optimized power routing.",
                modelName: nil
            )
        ]
    }
}