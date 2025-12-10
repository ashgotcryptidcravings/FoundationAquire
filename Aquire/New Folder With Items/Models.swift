import Foundation
import SwiftUI
// MARK: - Models

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: Double
    let imageSystemName: String
    let category: String
    let description: String
    let modelName: String?    // USDZ file name without extension
}

struct Order: Identifiable {
    let id = UUID()
    let product: Product
    let date: Date
    var status: OrderStatus
}

enum OrderStatus: String, CaseIterable {
    case processing = "Processing"
    case preparing  = "Preparing for Shipment"
    case shipped    = "Shipped"
    case delivered  = "Delivered"

    var displayName: String { rawValue }

    var next: OrderStatus? {
        switch self {
        case .processing: return .preparing
        case .preparing:  return .shipped
        case .shipped:    return .delivered
        case .delivered:  return nil
        }
    }

    var tint: SwiftUI.Color {
        switch self {
        case .processing: return .orange
        case .preparing:  return .yellow
        case .shipped:    return .blue
        case .delivered:  return .green
        }
    }
}

// MARK: - Sample Products

let products: [Product] = [
    Product(
        name: "AdvancaLink",
        price: 299.99,
        imageSystemName: "iphone",
        category: "Devices",
        description: "A next-gen Foundation handset that links every layer of your ecosystem together. Designed for seamless handoff between reality, VR, and FoundationOS.",
        modelName: "AdvancaLink"   // expects AdvancaLink.usdz in the bundle
    ),
    Product(
        name: "OnyxGlove V2",
        price: 349.00,
        imageSystemName: "hand.raised.fill",
        category: "Wearables",
        description: "A modular control glove for gestural input, haptic feedback, and real-time system control.",
        modelName: nil
    ),
    Product(
        name: "Foundation Dock",
        price: 199.00,
        imageSystemName: "macmini.fill",
        category: "Docking",
        description: "A low-profile dock that powers and synchronizes your entire Foundation cluster.",
        modelName: nil
    )
]

// Fast lookup table: product.id → Product
let productsByID: [UUID: Product] = {
    Dictionary(uniqueKeysWithValues: products.map { ($0.id, $0) })
}()
