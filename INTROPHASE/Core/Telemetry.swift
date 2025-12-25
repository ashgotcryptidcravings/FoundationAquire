//
//  Telemetry.swift
//  Aquire
//

import Foundation
import SwiftUI

@MainActor
final class Telemetry: ObservableObject {

    @Published private(set) var events: [TelemetryEvent] = []

    func log(_ message: String, source: String = "app") {
        events.insert(TelemetryEvent(message: message, source: source, date: Date()), at: 0)
    }

    func clear() {
        events.removeAll()
    }
}

struct TelemetryEvent: Identifiable, Hashable {
    let id = UUID()
    let message: String
    let source: String
    let date: Date
}
