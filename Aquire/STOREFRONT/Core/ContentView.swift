import SwiftUI

struct ContentView: View {
    // Accept objects injected by the parent shells; avoid creating duplicates here.
    @EnvironmentObject private var session: SessionModel
    @EnvironmentObject private var profile: AppProfile
    @EnvironmentObject private var performance: PerformanceProfile
    @EnvironmentObject private var telemetry: Telemetry

    var body: some View {
        RootShellView()
    }
}