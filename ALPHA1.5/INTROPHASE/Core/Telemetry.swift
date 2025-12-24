//
//  Telemetry.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import SwiftUI

/// Minimal opt-in telemetry for debugging performance and usage.
/// No personal data. No identifiers. Just app-level events.
final class Telemetry: ObservableObject {

    struct Event: Identifiable {
        let id = UUID()
        let date: Date
        let name: String
        let detail: String
    }

    @Published private(set) var events: [Event] = []

    func log(_ name: String, _ detail: String = "") {
        events.insert(Event(date: Date(), name: name, detail: detail), at: 0)

        // Keep memory bounded.
        if events.count > 200 {
            events.removeLast(events.count - 200)
        }
    }

    func clear() {
        events.removeAll()
    }
}