import SwiftUI

/// Lightweight helper to apply a subtle "Liquid Glass" style (uses system materials + blur + inner highlight).
/// This is intentionally minimal and works across iOS 15+ while matching the new iOS 26 Liquid Glass look when available.
struct LiquidGlass: ViewModifier {
    var cornerRadius: CGFloat = 16
    var opacity: Double = 0.12

    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color.white.opacity(0.06), lineWidth: 0.5)
                    .blendMode(.overlay)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: Color.black.opacity(0.18), radius: 8, x: 0, y: 4)
    }
}

extension View {
    func liquidGlass(cornerRadius: CGFloat = 16) -> some View {
        modifier(LiquidGlass(cornerRadius: cornerRadius))
    }
}
