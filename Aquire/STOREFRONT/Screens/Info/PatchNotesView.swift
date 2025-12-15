//
//  PatchNotesView.swift
//  Aquire
//
//  Created by Zero on 12/15/25.
//


import SwiftUI

/// Drop-in Patch Notes screen.
/// File: `STOREFRONT/Screens/Info/PatchNotesView.swift`
struct PatchNotesView: View {
    @EnvironmentObject private var telemetry: Telemetry

    // Keep this stupid-simple: newest at top.
    private let releases: [PatchRelease] = [
        PatchRelease(
            version: "Alpha 1.7.2",
            codename: nil,
            dateText: "Dec 15, 2025",
            bullets: [
                "Fixed a few buttons not working.",
                "Optimized a few menus (traded some visuals for efficiency).",
                "Full motion toward ALPHA 2.0."
            ],
            disclaimer: "Developer alpha. Not pushed to main. Expect major bugs."
        ),
        PatchRelease(
            version: "Alpha 2.0",
            codename: "Expansion",
            dateText: "TBD",
            bullets: [
                "Home rails + browse flow overhaul.",
                "Wishlist + Acquired pipelines stabilized.",
                "Performance profiles + motion gating.",
                "tvOS focus + cinematic polish pass."
            ],
            disclaimer: "Work-in-progress."
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                AquireHeader(title: "Patch Notes", subtitle: "What changed. What improved. What broke.")

                ForEach(releases) { r in
                    PatchReleaseCard(release: r)
                }

                Spacer(minLength: 8)
            }
            .padding(18)
        }
        .aquireBackground()
        .onAppear { telemetry.log("screen_show", "PatchNotes") }
    }
}

// MARK: - Models

private struct PatchRelease: Identifiable {
    let id = UUID()
    let version: String
    let codename: String?
    let dateText: String
    let bullets: [String]
    let disclaimer: String?
}

// MARK: - Card

private struct PatchReleaseCard: View {
    let release: PatchRelease

    var body: some View {
        AquireSurface(cornerRadius: 26, padding: 16) {
            VStack(alignment: .leading, spacing: 12) {

                HStack(alignment: .firstTextBaseline) {
                    Text(release.version)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.95))

                    if let codename = release.codename, !codename.isEmpty {
                        Text(codename.uppercased())
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.75))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.10))
                                    .overlay(Capsule().stroke(Color.white.opacity(0.18), lineWidth: 0.8))
                            )
                    }

                    Spacer()

                    Text(release.dateText)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(release.bullets, id: \.self) { line in
                        HStack(alignment: .top, spacing: 10) {
                            Text("•")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white.opacity(0.65))
                                .padding(.top, 1)

                            Text(line)
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .foregroundColor(.white.opacity(0.75))
                        }
                    }
                }

                if let disclaimer = release.disclaimer, !disclaimer.isEmpty {
                    Divider().opacity(0.12)

                    Text(disclaimer)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.55))
                }
            }
        }
        .pressable(0.99)
    }
}

import Foundation
import SwiftUI

/// Minimal patch-note logger you can call anywhere.
/// File: `STOREFRONT/Core/PatchNotesStore.swift`
@MainActor
final class PatchNotesStore: ObservableObject {
    @Published var releases: [PatchNotesStore.Release] = []

    init(seedDefault: Bool = true) {
        if seedDefault { seed() }
    }

    func addRelease(_ release: Release) {
        releases.insert(release, at: 0) // newest first
    }

    func addBullet(toVersion version: String, bullet: String) {
        guard let idx = releases.firstIndex(where: { $0.version == version }) else { return }
        releases[idx].bullets.insert(bullet, at: 0)
    }

    private func seed() {
        releases = [
            Release(
                version: "Alpha 1.7.2",
                codename: nil,
                dateText: "Dec 15, 2025",
                bullets: [
                    "Fixed a few buttons not working.",
                    "Optimized a few menus (traded some visuals for efficiency).",
                    "Full motion toward ALPHA 2.0."
                ],
                disclaimer: "Developer alpha. Not pushed to main. Expect major bugs."
            )
        ]
    }

    struct Release: Identifiable, Hashable {
        let id = UUID()
        var version: String
        var codename: String?
        var dateText: String
        var bullets: [String]
        var disclaimer: String?
    }
}

import SwiftUI

/// Patch Notes screen powered by PatchNotesStore.
/// File: `STOREFRONT/Screens/Info/PatchNotesView.swift`
struct PatchNotesView: View {
    @EnvironmentObject private var telemetry: Telemetry
    @EnvironmentObject private var patchNotes: PatchNotesStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                AquireHeader(title: "Patch Notes", subtitle: "What changed. What improved. What broke.")

                ForEach(patchNotes.releases) { r in
                    PatchReleaseCard(release: r)
                }

                Spacer(minLength: 8)
            }
            .padding(18)
        }
        .aquireBackground()
        .onAppear { telemetry.log("screen_show", "PatchNotes") }
    }
}

private struct PatchReleaseCard: View {
    let release: PatchNotesStore.Release

    var body: some View {
        AquireSurface(cornerRadius: 26, padding: 16) {
            VStack(alignment: .leading, spacing: 12) {

                HStack(alignment: .firstTextBaseline) {
                    Text(release.version)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.95))

                    if let codename = release.codename, !codename.isEmpty {
                        Text(codename.uppercased())
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.75))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.10))
                                    .overlay(Capsule().stroke(Color.white.opacity(0.18), lineWidth: 0.8))
                            )
                    }

                    Spacer()

                    Text(release.dateText)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(release.bullets, id: \.self) { line in
                        HStack(alignment: .top, spacing: 10) {
                            Text("•")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white.opacity(0.65))
                                .padding(.top, 1)

                            Text(line)
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .foregroundColor(.white.opacity(0.75))
                        }
                    }
                }

                if let disclaimer = release.disclaimer, !disclaimer.isEmpty {
                    Divider().opacity(0.12)

                    Text(disclaimer)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.55))
                }
            }
        }
        .pressable(0.99)
    }
}