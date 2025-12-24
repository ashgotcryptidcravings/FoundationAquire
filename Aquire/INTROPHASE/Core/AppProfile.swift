import SwiftUI

@MainActor
final class AppProfile: ObservableObject {

    enum Experience: String, CaseIterable, Identifiable {
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

    typealias UserExperience = Experience

    @Published var experience: Experience {
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
        static let experience             = "Aquire.profile.experience"
        static let telemetryOptIn         = "Aquire.profile.telemetryOptIn"
        static let hasCompletedOnboarding = "Aquire.profile.hasCompletedOnboarding"
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        if let raw = defaults.string(forKey: Keys.experience),
           let exp = Experience(rawValue: raw) {
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
