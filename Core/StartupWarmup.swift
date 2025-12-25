//
//  StartupWarmup.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import Foundation
import SwiftUI

// Removed @MainActor so the detached background Task actually runs off-main.
enum StartupWarmup {

    static func run() {
        // Touch catalog once to warm dictionary / decoding / allocations.
        // Do the bulk of these touches off the main actor to avoid delaying the first frame.
        Task.detached(priority: .background) {
            _ = ProductCatalog.all

            // Touch currency formatting once (expensive on first call sometimes).
            let f = FloatingPointFormatStyle<Double>.Currency(code: "USD")
            _ = 199.0.formatted(f)

            // Small sleep to yield — background sleep
            try? await Task.sleep(nanoseconds: 1_000_000)

            // If any UI-updates are required from this warm-up, dispatch to the main actor explicitly.
        }
    }
}