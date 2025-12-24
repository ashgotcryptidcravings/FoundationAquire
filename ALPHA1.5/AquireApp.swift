import SwiftUI

@main
struct AquireApp: App {

    @StateObject private var store = StoreModel()
    @StateObject private var performance = PerformanceProfile()
    @StateObject private var profile = AppProfile()
    @StateObject private var telemetry = Telemetry()

    var body: some Scene {
        WindowGroup {
            RootGateView()
                .environmentObject(store)
                .environmentObject(performance)
                .environmentObject(profile)
                .environmentObject(telemetry)
                .onAppear {
                    // Map AppProfile experience to PerformanceProfile preference
                    performance.preference = profile.experience.mapsToPreference
                    telemetry.log("app_launch", "experience=\(profile.experience.rawValue)")
                }
                .onChange(of: profile.experience) { _, newValue in
                    performance.preference = newValue.mapsToPreference
                    telemetry.log("profile_experience_changed", newValue.rawValue)
                }
        }
    }
}

/// Routes to onboarding first, then the actual app content.
/// Keeps ContentView clean.
struct RootGateView: View {
    @EnvironmentObject private var profile: AppProfile

    var body: some View {
        if profile.hasCompletedOnboarding {
            ContentView()
        } else {
            OnboardingView()
        }
    }
}
