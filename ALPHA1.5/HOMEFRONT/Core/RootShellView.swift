//
//  RootShellView.swift
//  Aquire
//
//  Created by Zero on 12/11/25.
//


import SwiftUI

/// Top-level shell deciding which "front" of Aquire to show:
/// - IntroPhase onboarding
/// - ClientFront (normal user-facing app)
/// - AdminFront (internal tools)
struct RootShellView: View {
    @EnvironmentObject private var session: SessionModel

    var body: some View {
        Group {
            if session.hasCompletedOnboarding {
                // Onboarding done: choose between client/admin fronts.
                mainFront
            } else {
                // First-run experience.
                OnboardingView()
            }
        }
    }

    @ViewBuilder
    private var mainFront: some View {
        switch session.userRole {
        case .client:
            ClientFrontShellView()
        case .admin:
            AdminFrontShellView()
        }
    }
}