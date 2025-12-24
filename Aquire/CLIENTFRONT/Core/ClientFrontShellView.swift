import SwiftUI

/// The normal user-facing app shell.
/// For now, it's basically: Storefront.
struct ClientFrontShellView: View {
    @StateObject private var router = StorefrontRouter()
    @StateObject private var gates = FeatureGates()
    // Lazy store instance only when the Client front (Storefront) is created
    @StateObject private var store = StoreModel()

    // Create heavy objects lazily only when ClientFront shows
    @StateObject private var profile = AppProfile()
    @StateObject private var performance = PerformanceProfile()
    @StateObject private var telemetry = Telemetry()

    var body: some View {
        StorefrontShellView()
            .environmentObject(router)
            .environmentObject(gates)
            .environmentObject(store) // inject store lazily here
            .environmentObject(profile)
            .environmentObject(performance)
            .environmentObject(telemetry)
    }
}