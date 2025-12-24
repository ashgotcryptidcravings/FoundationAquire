import SwiftUI

/// Lightweight overlay for quick internal state checks.
/// Safe with the new keyed StoreModel (wishlist: Set<String>, acquired: [String:Int], orders: [Order]).
struct DebugOverlay: View {
    @EnvironmentObject private var store: StoreModel

    @State private var expanded: Bool = false

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Spacer()

                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 10) {
                        Text("Debug")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))

                        Spacer()

                        Button {
                            expanded.toggle()
                        } label: {
                            Image(systemName: expanded ? "chevron.down" : "chevron.up")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white.opacity(0.85))
                                .padding(6)
                                .background(
                                    Circle().fill(Color.white.opacity(0.10))
                                )
                        }
                        .buttonStyle(.plain)
                    }

                    HStack(spacing: 12) {
                        stat("Wishlist", value: store.wishlist.count)
                        stat("Acquired", value: store.acquired.count)
                        stat("Orders", value: store.orders.count)
                    }

                    if expanded {
                        Divider().background(Color.white.opacity(0.15))

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Acquired (keys)")
                                .font(.system(size: 11, weight: .bold, design: .rounded))
                                .foregroundColor(.white.opacity(0.75))

                            let keys = store.acquired.keys.sorted().prefix(6)
                            if keys.isEmpty {
                                Text("None")
                                    .font(.system(size: 11, weight: .regular, design: .rounded))
                                    .foregroundColor(.white.opacity(0.6))
                            } else {
                                ForEach(Array(keys), id: \.self) { key in
                                    let qty = store.acquired[key, default: 0]
                                    Text("• \(key)  x\(qty)")
                                        .font(.system(size: 11, weight: .regular, design: .rounded))
                                        .foregroundColor(.white.opacity(0.7))
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                }
                .padding(12)
                .frame(width: expanded ? 280 : 240)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.black.opacity(0.55))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(Color.white.opacity(0.12), lineWidth: 0.8)
                        )
                )
                .padding(14)
            }
        }
        .allowsHitTesting(true)
    }

    private func stat(_ title: String, value: Int) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 10, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.6))
            Text("\(value)")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.white.opacity(0.12), lineWidth: 0.8)
                )
        )
    }
}
