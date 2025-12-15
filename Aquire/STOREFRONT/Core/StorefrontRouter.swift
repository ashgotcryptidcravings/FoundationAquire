//
//  StorefrontRouter.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import SwiftUI

final class StorefrontRouter: ObservableObject {
    @Published var selected: StorefrontRoute = .home

    // Future: deep links, sheets, navigation stacks, etc.
    func go(_ route: StorefrontRoute) {
        selected = route
    }
}