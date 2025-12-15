//
//  AppProfile.swift
//  Aquire
//
//  Created by Zero on 12/15/25.
//


import SwiftUI

/// User-facing “how should the app feel” profile.
/// This is intentionally an ObservableObject because the app observes it everywhere.
@MainActor
final class AppProfile: ObservableObject {

    // MARK: - User Experience

    enum UserExperience: String, CaseIterable, Identifiable {
        case performance
        case balanced
        case cinematic

        var id: String { rawValue }

        var title: String {
            switch self {
            case .performance: return "Performance"
            case .balanced:    return "Balanced"
            case .cinematic:   return "Cinematic"
            }
        }

        var subtitle: String {
            switch self {
            case .performance: return "Fewer effects, fastest feel."
            case .balanced:    return "Smooth + pretty, default."
            case .cinematic:   return "Full glass + motion (best devices)."
            }
        }
    }

    /// Back-compat alias because your app code uses `AppProfile.Experience`
    typealias Experience = UserExperience

    // MARK: - Stored properties

    @Published var experience: UserExperience {
        didSet { defaults.set(experience.rawValue, forKey: Keys.experience) }
    }

    @Published var telemetryOptIn: Bool {
        didSet { defaults.set(telemetryOptIn, forKey: Keys.telemetryOptIn) }
    }

    @Published var hasCompletedOnboarding: Bool {
        didSet { defaults.set(hasCompletedOnboarding, forKey: Keys.hasCompletedOnboarding) }
    }

    private let defaults: UserDefaults

    private struct Keys {
        static let experience              = "Aquire.profile.experience"
        static let telemetryOptIn          = "Aquire.profile.telemetryOptIn"
        static let hasCompletedOnboarding  = "Aquire.profile.hasCompletedOnboarding"
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        if let raw = defaults.string(forKey: Keys.experience),
           let exp = UserExperience(rawValue: raw) {
            self.experience = exp
        } else {
            self.experience = .balanced
        }

        self.telemetryOptIn = defaults.object(forKey: Keys.telemetryOptIn) == nil
            ? true
            : defaults.bool(forKey: Keys.telemetryOptIn)

        self.hasCompletedOnboarding = defaults.bool(forKey: Keys.hasCompletedOnboarding)
    }
}