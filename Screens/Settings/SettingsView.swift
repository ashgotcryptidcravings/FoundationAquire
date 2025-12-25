//
//  SettingsView.swift
//  Aquire
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var profile: AppProfile
    @EnvironmentObject private var performance: PerformanceProfile
    @EnvironmentObject private var telemetry: Telemetry

    var body: some View {
        ScreenScaffold("Settings", subtitle: "Performance, appearance, and developer tools.", source: "settings") {

            VStack(spacing: 14) {

                AquireHeroCard(
                    title: "Experience",
                    subtitle: "Auto-tunes visuals based on device state.",
                    systemImage: "sparkles"
                ) {
                    VStack(spacing: 12) {
                        Picker("Experience", selection:$profile.experience) {
                            ForEach(AppProfile.UserExperience.allCases, id: \.self) { exp in
                                Text(exp.title).tag(exp)
                            }
                        }
                        .pickerStyle(.segmented)

                        HStack(spacing: 10) {
                            AquireStatTile(
                                title: "Tier",
                                value: performance.tier.rawValue.capitalized,
                                systemImage: "gauge.with.dots.needle.50percent"
                            )

                            AquireStatTile(
                                title: "Thermal",
                                value: performance.thermalState.friendlyName,
                                systemImage: "thermometer"
                            )
                        }

                        HStack(spacing: 10) {
                            AquireStatTile(
                                title: "Power",
                                value: performance.isLowPowerMode ? "Low Power Mode" : "Normal",
                                systemImage: performance.isLowPowerMode ? "bolt.fill" : "bolt"
                            )

                            AquireStatTile(
                                title: "Throttle",
                                value: performance.systemThrottleActive ? "Active" : "Inactive",
                                systemImage: performance.systemThrottleActive ? "exclamationmark.triangle.fill" : "checkmark.circle"
                            )
                        }
                    }
                }

                Button {
                    telemetry.clear()
                } label: {
                    Text("Clear Local Telemetry")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.plain)
                .padding(.top, 4)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.white.opacity(0.08))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Color.white.opacity(0.10), lineWidth: 1)
                )
            }
        }
    }
}
