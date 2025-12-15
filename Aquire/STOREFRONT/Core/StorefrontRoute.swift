//
//  StorefrontRoute.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import Foundation

enum StorefrontRoute: String, CaseIterable, Identifiable {
    case home
    case browse
    case wishlist
    case acquired
    case orders
    case info
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .browse: return "Browse"
        case .wishlist: return "Wishlist"
        case .acquired: return "Acquired"
        case .orders: return "Orders"
        case .info: return "Info"
        case .settings: return "Settings"
        }
    }

    var systemIcon: String {
        switch self {
        case .home: return "sparkles"
        case .browse: return "square.grid.2x2"
        case .wishlist: return "bookmark"
        case .acquired: return "checkmark.seal"
        case .orders: return "shippingbox"
        case .info: return "info.circle"
        case .settings: return "gearshape"
        }
    }
}