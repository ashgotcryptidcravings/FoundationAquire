//
//  AppProfile.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import SwiftUI

/// Stores user/device profile choices used across the app.
/// This is the “edition” system — without maintaining a million SKUs.
final class AppProfile: ObservableObject {

    enum UserExperience: String, CaseIterable, Identifiable {
        case performance
        case balanced
        case cinematic

        var id: String { rawValue }

        var title: String {
            switch self {
            case .performance: return "Performance"
            case .balanced: return "Balanced"
            case .cinematic: return "Cinematic"
            }
        }

        var subtitle: String {
            switch self {
            case .performance: return "Fastest. Minimal blur, minimal animation."
            case .balanced: return "Recommended. Smooth, with tasteful glass."
            case .cinematic: return "Maximum glass + motion when the device can handle it."
            }
        }

        var mapsToPreference: AquirePerformancePreference {
            switch self {
            case .performance: return .battery
            case .balanced: return .balanced
            case .cinematic: return .cinematic
            }
        }
    }

    @Published var experience: UserExperience {
        didSet { UserDefaults.standard.set(experience.rawValue, forKey: Keys.experience) }
    }

    @Published var telemetryOptIn: Bool {
        didSet { UserDefaults.standard.set(telemetryOptIn, forKey: Keys.telemetryOptIn) }
    }

    @Published var hasCompletedOnboarding: Bool {
        didSet { UserDefaults.standard.set(hasCompletedOnboarding, forKey: Keys.didOnboard) }
    }

    private struct Keys {
        static let experience = "Aquire_profileExperience"
        static let telemetryOptIn = "Aquire_telemetryOptIn"
        static let didOnboard = "Aquire_didCompleteOnboarding"
    }

    init() {
        if let raw = UserDefaults.standard.string(forKey: Keys.experience),
           let exp = UserExperience(rawValue: raw) {
            self.experience = exp
        } else {
            self.experience = .balanced
        }

        if UserDefaults.standard.object(forKey: Keys.telemetryOptIn) == nil {
            self.telemetryOptIn = false
        } else {
            self.telemetryOptIn = UserDefaults.standard.bool(forKey: Keys.telemetryOptIn)
        }

        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: Keys.didOnboard)
    }
}