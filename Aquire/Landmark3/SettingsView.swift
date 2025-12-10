import SwiftUI

struct SettingsView: View {
    // MARK: - Env / State

    @EnvironmentObject var store: StoreModel
    @Environment(\.dismiss) private var dismiss

    /// Developer mode persisted across launches.
    @AppStorage("Aquire_developerUnlocked")
    private var developerUnlocked: Bool = false

    /// Global debug overlay toggle.
    @AppStorage("Aquire_debugOverlayEnabled")
    private var debugOverlayEnabled: Bool = false

    @State private var showAdminPanel: Bool = false

    // MARK: - Body

    var body: some View {
        ZStack {
            // Dim the app behind
            Color.black.opacity(0.55)
                .ignoresSafeArea()

            VStack {
                Spacer(minLength: 0)

                VStack(spacing: 0) {
                    header

                    Divider()
                        .background(Color.white.opacity(0.08))

                    ScrollView {
                        VStack(spacing: 16) {
                            accountSection
                            diagnosticsSection
                            developerSection
                        }
                        .padding(16)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .stroke(Color.white.opacity(0.08), lineWidth: 1)
                        )
                )
                .shadow(color: .black.opacity(0.6),
                        radius: 30, x: 0, y: 20)
                .padding(.horizontal, 32)
                .padding(.vertical, 28)

                Spacer(minLength: 0)
            }
        }
        .sheet(isPresented: $showAdminPanel) {
            #if os(macOS)
            AdminPanelView()
                .environmentObject(store)
            #else
            AdminPanelPhoneDebugView(
                debugOverlayEnabled: $debugOverlayEnabled
            )
            #endif
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white.opacity(0.9))
                    .frame(width: 28, height: 28)
            }
            .buttonStyle(.plain)

            Spacer()

            Text("Settings")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)

            Spacer()

            // Balance the close button
            Color.clear
                .frame(width: 28, height: 28)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }

    // MARK: - Sections

    private var accountSection: some View {
        SettingsSectionCard(
            title: "Account",
            subtitle: "Your Foundation identity"
        ) {
            SettingsRow(
                icon: "person.circle.fill",
                title: "Signed In",
                detail: "Aquire Demo Account"
            )

            SettingsRow(
                icon: "lock.shield.fill",
                title: "Entitlements",
                detail: "Local-only sandbox"
            )
        }
    }

    private var diagnosticsSection: some View {
        SettingsSectionCard(
            title: "Diagnostics",
            subtitle: "Store and account telemetry"
        ) {
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
                detail: store.totalSpent.formatted(.currency(code: "USD"))
            )
        }
    }

    private var developerSection: some View {
        SettingsSectionCard(
            title: "Developer",
            subtitle: "Internal Foundation diagnostics"
        ) {
            ToggleRow(
                icon: "chevron.left.slash.chevron.right",
                title: "Developer Mode",
                isOn: $developerUnlocked
            )

            ToggleRow(
                icon: "ladybug.fill",
                title: "Debug Overlay",
                isOn: $debugOverlayEnabled
            )

            ButtonRow(
                icon: "wrench.and.screwdriver.fill",
                title: "Admin Panel"
            ) {
                showAdminPanel = true
            }

            ButtonRow(
                icon: "trash.fill",
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

struct SettingsSectionCard<Content: View>: View {
    let title: String
    let subtitle: String
    @ViewBuilder var content: Content

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
                        .fill(tint.opacity(0.18))

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
        .buttonStyle(.plain)
    }
}

// MARK: - iPhone Admin Fallback

#if os(iOS)
struct AdminPanelPhoneDebugView: View {
    @Binding var debugOverlayEnabled: Bool

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Admin Tools")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)

                Text("Full Admin Panel lives on macOS.\nOn iPhone you get a lightweight debug console.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 14))

                Toggle(isOn: $debugOverlayEnabled) {
                    Label("Debug Overlay", systemImage: "ladybug.fill")
                }
                .tint(.purple)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                )

                Spacer()
            }
            .padding(24)
        }
    }
}
#endif
