import SwiftUI

struct SettingsView: View {
    // MARK: - Environment / State

    @EnvironmentObject var store: StoreModel
    @Environment(\.dismiss) private var dismiss

    /// Developer mode persisted across launches.
    @AppStorage("Aquire_developerUnlocked")
    private var developerUnlocked: Bool = false

    /// Global debug overlay toggle.
    @AppStorage("Aquire_debugOverlayEnabled")
    private var debugOverlayEnabled: Bool = false

    @AppStorage("Aquire_userEmail")
    private var storedEmail: String = ""

    @AppStorage("Aquire_isLoggedIn")
    private var isLoggedIn: Bool = false

    @State private var showingAdminPanel: Bool = false
    @State private var showingDebugPanel: Bool = false

    var body: some View {
        ZStack {
            AquireBackgroundView()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        entitlementsSection
                        diagnosticsSection
                        developerSection
                        consoleSection
                    }
                    .padding(20)
                    .padding(.bottom, 24)
                }
            }
        }
        .sheet(isPresented: $showingAdminPanel) {
            if #available(macOS 13.0, *) {
                AdminPanelView()
                    .environmentObject(store)
                    .preferredColorScheme(.dark)
            } else {
                Text("Admin panel requires macOS 13 or later.")
                    .padding()
                    .background(AquireBackgroundView())
            }
        }
        .sheet(isPresented: $showingDebugPanel) {
            DebugPanelView()
                .environmentObject(store)
                .preferredColorScheme(.dark)
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white.opacity(0.85))
            }
            .buttonStyle(.plain)

            Spacer()

            Text("Settings")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.white)

            Spacer()

            // Spacer to keep title centered
            Color.clear
                .frame(width: 22, height: 22)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }

    // MARK: - Sections

    private var entitlementsSection: some View {
        SettingsSectionCard(
            title: "Entitlements",
            subtitle: "Current sandbox state"
        ) {
            HStack(spacing: 14) {
                RoundedIcon(systemName: "lock.fill", tint: .purple)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Local-only sandbox")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)

                    Text("All purchases and data are stored on-device for this demo.")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()
            }
        }
    }

    private var diagnosticsSection: some View {
        SettingsSectionCard(
            title: "Diagnostics",
            subtitle: "Store and account telemetry"
        ) {
            SettingsRow(
                icon: "person.crop.circle",
                title: "Signed In",
                detail: storedEmail.isEmpty ? "Demo account" : storedEmail
            )

            SettingsRow(
                icon: "shippingbox.fill",
                title: "Acquired Items",
                detail: "\(store.acquiredProducts.count)"
            )

            SettingsRow(
                icon: "star.fill",
                title: "Wishlist Items",
                detail: "\(store.wishlistProducts.count)"
            )

            SettingsRow(
                icon: "list.bullet.rectangle.portrait",
                title: "Orders",
                detail: "\(store.orders.count)"
            )

            SettingsRow(
                icon: "creditcard.fill",
                title: "Total Spent",
                detail: store.totalSpent,
                formatAsCurrency: true
            )
        }
    }

    private var developerSection: some View {
        SettingsSectionCard(
            title: "Developer",
            subtitle: "Internal Foundation diagnostics"
        ) {
            Toggle(isOn: $developerUnlocked) {
                SettingsToggleLabel(
                    icon: "chevron.left.forwardslash.chevron.right",
                    title: "Developer Mode",
                    subtitle: "Enables debug tooling and overlay"
                )
            }
            .tint(.purple)

            Toggle(isOn: $debugOverlayEnabled) {
                SettingsToggleLabel(
                    icon: "ladybug.fill",
                    title: "Debug Overlay",
                    subtitle: "Shows real-time layout + state"
                )
            }
            .tint(.purple)
            .disabled(!developerUnlocked)
            .opacity(developerUnlocked ? 1 : 0.4)

            Divider().background(Color.white.opacity(0.1))
                .padding(.vertical, 4)

            Button {
                showingAdminPanel = true
            } label: {
                SettingsRowButton(
                    icon: "wrench.and.screwdriver.fill",
                    title: "Admin Panel",
                    tint: .purple
                )
            }
            .buttonStyle(.plain)
            .disabled(!developerUnlocked)
            .opacity(developerUnlocked ? 1 : 0.4)

            Button {
                showingDebugPanel = true
            } label: {
                SettingsRowButton(
                    icon: "terminal.fill",
                    title: "Console",
                    tint: .pink
                )
            }
            .buttonStyle(.plain)

            Button(role: .destructive) {
                store.resetAll()
            } label: {
                SettingsRowButton(
                    icon: "trash.fill",
                    title: "Reset Demo Data",
                    tint: .red
                )
            }
            .buttonStyle(.plain)
            .padding(.top, 4)
        }
    }

    private var consoleSection: some View {
        SettingsSectionCard(
            title: "Console",
            subtitle: "Build information"
        ) {
            HStack(spacing: 14) {
                RoundedIcon(systemName: "app.badge.fill", tint: .purple)

                VStack(alignment: .leading, spacing: 3) {
                    Text("Aquire v1.0")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)

                    Text("Build 001 • Local preview")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                }

                Spacer()
            }
        }
    }
}

// MARK: - Section Card

private struct SettingsSectionCard<Content: View>: View {
    let title: String
    let subtitle: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.purple.opacity(0.9))

            Text(subtitle)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.7))

            VStack(spacing: 10) {
                content
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color.white.opacity(0.04))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(Color.white.opacity(0.06), lineWidth: 0.8)
                    )
            )
        }
    }
}

// MARK: - Rows, labels, helpers

private struct SettingsRow: View {
    let icon: String
    let title: String
    var detail: Any
    var formatAsCurrency: Bool = false

    var body: some View {
        HStack(spacing: 14) {
            RoundedIcon(systemName: icon, tint: .purple)

            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.white)

            Spacer()

            Text(detailText)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.vertical, 4)
    }

    private var detailText: String {
        if formatAsCurrency, let value = detail as? Double {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = "USD"
            return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
        } else {
            return String(describing: detail)
        }
    }
}

private struct SettingsToggleLabel: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 14) {
            RoundedIcon(systemName: icon, tint: .purple)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)

                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

private struct SettingsRowButton: View {
    let icon: String
    let title: String
    let tint: Color

    var body: some View {
        HStack(spacing: 14) {
            RoundedIcon(systemName: icon, tint: tint)

            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)

            Spacer()
        }
        .padding(.vertical, 6)
    }
}

private struct RoundedIcon: View {
    let systemName: String
    let tint: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(tint.opacity(0.2))

            Image(systemName: systemName)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(tint)
        }
        .frame(width: 32, height: 32)
    }
}
