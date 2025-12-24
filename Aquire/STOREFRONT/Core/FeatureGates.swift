//
//  FeatureGates.swift
//  Aquire
//

import Foundation

@MainActor
final class FeatureGates: ObservableObject {
    struct Gates {
        var allowHighlightOverlay: Bool = true
        var allow3DPreview: Bool = true
        var allowLiquidGlass: Bool = true
    }

    @Published var gates: Gates = .init()
}
