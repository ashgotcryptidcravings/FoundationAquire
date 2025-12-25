import SwiftUI
@main
struct AquireApp: App {
    // Keep only the lightweight session at app launch to reduce startup cost
    @StateObject private var session = SessionModel()

    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .environmentObject(session)
                // NOTE: App-level objects like AppProfile, PerformanceProfile, and
                // Telemetry are intentionally NOT created here to avoid work on
                // app startup. They should be instantiated lazily by the
                // front-end shells (e.g. ClientFrontShellView) that actually
                // need them.
        }
    }
}
