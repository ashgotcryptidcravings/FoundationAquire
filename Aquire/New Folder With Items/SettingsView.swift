import SwiftUI

struct SettingsView: View {
    /// If true, show the Developer section.
    let developerUnlocked: Bool

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: StoreModel

    @AppStorage("Aquire_debugOverlayEnabled") private var debugOverlayEnabled: Bool = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // Faux nav bar
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white.opacity(0.8))
                    }

                    Spacer()

                    Text("Settings")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)

                    Spacer()

                    Color.clear.frame(width: 24, height: 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 8)

                Divider().background(Color.white.opacity(0.1))

                ScrollView {
                    VStack(spacing: 14) {
                        generalSection
                        appearanceSection

                        if developerUnlocked {
                            developerSection
                        }
                    }
                    .padding(16)
                }
            }
        }
    }

    // MARK: - Sections

    private var generalSection: some View {
        SettingsCard(title: "General", subtitle: "Your Foundation account basics") {
            SettingsRow(
                icon: "person.crop.circle",
                title: "Signed in",
                detail: "Aquire Account"
            )

            SettingsRow(
                icon: "gamecontroller.fill",
                title: "Account Level",
                detail: "Level \(store.level) · \(store.xp) XP"
            )

            SettingsRow(
                icon: "icloud",
                title: "Cloud Sync",
                detail: "Local-only (demo)"
            )
        }
    }

    private var appearanceSection: some View {
        SettingsCard(title: "Appearance", subtitle: "App visual style") {
            SettingsRow(
                icon: "moon.fill",
                title: "Theme",
                detail: "Foundation Dark"
            )

            SettingsRow(
                icon: "sparkles",
                title: "Accent",
                detail: "Prismatic Violet"
            )
        }
    }

    private var developerSection: some View {
        SettingsCard(
            title: "Developer",
            subtitle: "Internal Foundation diagnostics"
        ) {
            ToggleRow(
                icon: "hammer.fill",
                title: "Debug Overlay",
                isOn: $debugOverlayEnabled
            )

            ButtonRow(
                icon: "trash",
                title: "Reset Demo Data",
                tint: .red
            ) {
                store.resetAll()
            }

            SettingsRow(
                icon: "terminal.fill",
                title: "Console",
                detail: "Aquire v1.0 · build 001"
            )
        }
    }
}

// MARK: - Reusable Settings UI

struct SettingsCard<Content: View>: View {
    let title: String
    let subtitle: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title.uppercased())
                    .font(.caption)
                    .foregroundColor(.purple.opacity(0.9))

                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
            }

            VStack(spacing: 0) {
                content
            }
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(red: 0.08, green: 0.08, blue: 0.08))
            )
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let detail: String

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white.opacity(0.06))
                Image(systemName: icon)
                    .foregroundColor(.purple)
                    .font(.system(size: 15, weight: .semibold))
            }
            .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))

                Text(detail)
                    .foregroundColor(.white.opacity(0.6))
                    .font(.system(size: 11))
            }

            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
    }
}

struct ToggleRow: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white.opacity(0.06))
                Image(systemName: icon)
                    .foregroundColor(.purple)
                    .font(.system(size: 15, weight: .semibold))
            }
            .frame(width: 32, height: 32)

            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
    }
}

struct ButtonRow: View {
    let icon: String
    let title: String
    var tint: Color = .purple
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(tint.opacity(0.15))
                    Image(systemName: icon)
                        .foregroundColor(tint)
                        .font(.system(size: 15, weight: .semibold))
                }
                .frame(width: 32, height: 32)

                Text(title)
                    .foregroundColor(tint)
                    .font(.system(size: 14, weight: .semibold))

                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
