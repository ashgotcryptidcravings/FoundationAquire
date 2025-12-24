import SwiftUI

struct AdminPanelView: View {
    @EnvironmentObject private var telemetry: Telemetry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                AquireHeader(title: "Admin", subtitle: "Internal tools (framework stub).")

                AquireSurface {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Coming Online")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))

                        Text("We’re rebuilding Admin tools against the new keyed ProductCatalog + StoreModel architecture.")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))

                        Text("Next: featured product, hidden products, badges, and debug toggles.")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.65))
                    }
                }
            }
            .padding(18)
        }
        .aquireBackground()
        .onAppear { telemetry.log("screen_show", source: "AdminPanel") }
    }
}
