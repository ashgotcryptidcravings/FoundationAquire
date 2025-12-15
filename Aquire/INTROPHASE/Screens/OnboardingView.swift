//
//  OnboardingView.swift
//  Aquire
//
//  Created by Zero on 12/11/25.
//


import SwiftUI

/// First-run onboarding + performance calibration.
/// Right now it's intentionally simple:
/// 1. Welcome
/// 2. Performance preference (Battery / Balanced / Cinematic)
/// 3. Auto-tune toggle + finish
struct OnboardingView: View {
    @EnvironmentObject private var session: SessionModel
    @EnvironmentObject private var performance: PerformanceProfile

    @State private var step: Int = 0

    var body: some View {
        ZStack {
            // Simple background for now; can be replaced with your liquid glass shell later.
            LinearGradient(
                colors: [
                    Color.black,
                    Color.blue.opacity(0.4),
                    Color.purple.opacity(0.7)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer(minLength: 40)

                switch step {
                case 0:
                    welcomeStep
                case 1:
                    performancePreferenceStep
                default:
                    autoTuneStep
                }

                Spacer()

                controls
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
    }

    // MARK: - Steps

    private var welcomeStep: some View {
        VStack(spacing: 16) {
            Text("Welcome to Aquire")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Text("We’ll take a moment to calibrate visuals to your device so everything feels smooth and intentional.")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
    }

    private var performancePreferenceStep: some View {
        VStack(spacing: 20) {
            Text("Choose your visual style")
                .font(.title2.bold())
                .foregroundColor(.white)

            Text("You can change this later in Settings.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))

            Picker("Performance Preference", selection: $performance.preference) {
                ForEach(AquirePerformancePreference.allCases) { option in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(option.label)
                            .font(.body.weight(.medium))
                        Text(option.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .tag(option)
                }
            }
            .pickerStyle(.inline)
            .tint(.white)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.black.opacity(0.4))
            )
        }
    }

    private var autoTuneStep: some View {
        VStack(spacing: 20) {
            Text("Let Aquire auto-tune visuals?")
                .font(.title2.bold())
                .foregroundColor(.white)

            Text("Aquire can monitor its own performance on this device and softly adjust effects to stay smooth. All tuning data stays on this device.")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))

            Toggle(isOn: $performance.autoTuneEnabled) {
                Text("Enable auto-tuning on this device")
                    .foregroundColor(.white)
            }
            .toggleStyle(.switch)
            .tint(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.black.opacity(0.4))
            )
        }
    }

    // MARK: - Controls

    private var controls: some View {
        HStack {
            if step > 0 {
                Button {
                    withAnimation(.easeOut(duration: 0.2)) {
                        step -= 1
                    }
                } label: {
                    Text("Back")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
                        )
                }
            }

            Spacer()

            Button {
                advance()
            } label: {
                Text(step < 2 ? "Continue" : "Finish Setup")
                    .font(.body.bold())
                    .foregroundColor(.black)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 22)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.white)
                    )
            }
        }
    }

    private func advance() {
        if step < 2 {
            withAnimation(.easeOut(duration: 0.25)) {
                step += 1
            }
        } else {
            // Finalize onboarding
            session.hasCompletedOnboarding = true
        }
    }
}