//
//  SessionModel.swift
//  Aquire
//
//  Created by Zero on 12/11/25.
//


import Foundation
import Combine

/// Global session state for Aquire's UI shells.
/// - Tracks whether the user has completed intro/onboarding.
/// - Tracks the active "front" role for the session (client vs admin).
final class SessionModel: ObservableObject {

    enum UserRole: String {
        case client
        case admin
    }

    // MARK: - Published properties

    @Published var hasCompletedOnboarding: Bool {
        didSet {
            defaults.set(hasCompletedOnboarding, forKey: Keys.hasCompletedOnboarding)
        }
    }

    @Published var userRole: UserRole {
        didSet {
            defaults.set(userRole.rawValue, forKey: Keys.userRole)
        }
    }

    // MARK: - Private

    private let defaults: UserDefaults

    private struct Keys {
        static let hasCompletedOnboarding = "Aquire_hasCompletedOnboarding"
        static let userRole = "Aquire_userRole"
    }

    // MARK: - Init

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        // Onboarding flag
        let storedOnboarding = defaults.object(forKey: Keys.hasCompletedOnboarding) as? Bool
        self.hasCompletedOnboarding = storedOnboarding ?? false

        // Role
        let storedRole = defaults.string(forKey: Keys.userRole)
        let resolvedRole = storedRole.flatMap { UserRole(rawValue: $0) } ?? .client
        self.userRole = resolvedRole
    }

    // MARK: - Helpers

    func resetForFreshStart() {
        hasCompletedOnboarding = false
        userRole = .client
    }
}