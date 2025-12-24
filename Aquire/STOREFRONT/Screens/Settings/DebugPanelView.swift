import SwiftUI

struct DebugPanelView: View {
    @EnvironmentObject private var store: StoreModel
    @EnvironmentObject private var telemetry: Telemetry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                AquireHeader(title: "Debug", subtitle: "Diagnostics (framework stub).")

                AquireSurface {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Store State Snapshot")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))

                        HStack {
                            Text("Wishlist")
                                .foregroundColor(.white.opacity(0.7))
                            Spacer()
                            Text("\(store.wishlist.count)")
                                .foregroundColor(.white.opacity(0.9))
                        }

                        HStack {
                            Text("Acquired")
                                .foregroundColor(.white.opacity(0.7))
                            Spacer()
                            Text("\(store.acquired.count)")
                                .foregroundColor(.white.opacity(0.9))
                        }

                        HStack {
                            Text("Orders")
                                .foregroundColor(.white.opacity(0.7))
                            Spacer()
                            Text("\(store.orders.count)")
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                }

                AquireSurface {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Note")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))

                        Text("Full debug tooling is coming back after Admin feature flags are rebuilt.")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.65))
                    }
                }
            }
            .padding(18)
        }
        .aquireBackground()
        .onAppear { telemetry.log("screen_show", source: "DebugPanel") }
    }
}
