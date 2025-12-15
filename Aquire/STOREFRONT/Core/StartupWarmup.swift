//
//  StartupWarmup.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import Foundation
import SwiftUI

@MainActor
enum StartupWarmup {

    static func run() {
        // Touch catalog once to warm dictionary / decoding / allocations.
        _ = ProductCatalog.all

        // Touch currency formatting once (expensive on first call sometimes).
        let f = FloatingPointFormatStyle<Double>.Currency(code: "USD")
        _ = 199.0.formatted(f)

        // Small async yield so first frame can land.
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 1_000_000) // 1ms
        }
    }
}