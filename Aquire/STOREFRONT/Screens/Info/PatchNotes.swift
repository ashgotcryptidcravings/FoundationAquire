//
//  PatchRelease.swift
//  Aquire
//
//  Created by Zero on 12/15/25.
//


//
//  PatchNotes.swift
//  Aquire
//

import Foundation

struct PatchRelease: Identifiable, Hashable {
    let id = UUID()
    let version: String
    let date: Date
    let summary: String
    let bullets: [String]
}

enum PatchNotes {
    static let releases: [PatchRelease] = [
        PatchRelease(
            version: "Alpha 1.7.2",
            date: ISO8601DateFormatter().date(from: "2025-12-15T00:00:00Z") ?? Date(),
            summary: "Stability + storefront groundwork.",
            bullets: [
                "Fixed buttons not responding in several screens.",
                "Optimized a few menus to reduce lag on older devices.",
                "Storefront model cleanup in preparation for Alpha 2.0."
            ]
        )
    ]
}