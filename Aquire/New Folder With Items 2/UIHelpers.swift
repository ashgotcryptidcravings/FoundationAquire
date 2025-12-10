import SwiftUI

// Global dark background helper
extension View {
    func aquireBackground() -> some View {
        self.background(Color.black.ignoresSafeArea())
    }
}

// Reusable status pill
struct StatusPill: View {
    let status: OrderStatus

    var body: some View {
        Text(status.displayName)
            .font(.caption2)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Capsule().fill(status.tint.opacity(0.25))
            )
            .foregroundColor(status.tint)
    }
}
