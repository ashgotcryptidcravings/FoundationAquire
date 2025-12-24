import SwiftUI

// MARK: - Background

struct AquireBackgroundView: View {
    @EnvironmentObject private var performance: PerformanceProfile

    var body: some View {
        let t = performance.currentTuning

        ZStack {
            Color.black.opacity(0.96)

            RadialGradient(
                gradient: Gradient(colors: [
                    Color.purple.opacity(0.28),
                    .clear
                ]),
                center: .topLeading,
                startRadius: 30,
                endRadius: 320
            )

            RadialGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.26),
                    .clear
                ]),
                center: .bottomTrailing,
                startRadius: 50,
                endRadius: 360
            )

            LinearGradient(
                colors: [Color.white.opacity(0.05), Color.clear],
                startPoint: .top,
                endPoint: .bottom
            )
            .blendMode(.screen)
            .opacity(0.45)
        }
        .modifier(BackgroundBlurIfAllowed(enabled: t.allowBackgroundBlur))
        .ignoresSafeArea()
    }
}

private struct BackgroundBlurIfAllowed: ViewModifier {
    let enabled: Bool
    func body(content: Content) -> some View {
        if enabled { content.blur(radius: 8) } else { content }
    }
}

// MARK: - Motion

enum AquireMotion {
    static let tap = Animation.interactiveSpring(
        response: 0.28,
        dampingFraction: 0.7,
        blendDuration: 0.15
    )
}

// MARK: - Frost Card (adaptive)

private struct FrostCardModifier: ViewModifier {
    let cornerRadius: CGFloat
    @EnvironmentObject private var performance: PerformanceProfile

    func body(content: Content) -> some View {
        let t = performance.currentTuning
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        let fill: AnyShapeStyle = {
            if t.blurStrength > 0 {
                #if os(tvOS)
                return AnyShapeStyle(Color.white.opacity(0.07))
                #else
                return AnyShapeStyle(.thinMaterial)
                #endif
            } else {
                return AnyShapeStyle(Color.white.opacity(0.055))
            }
        }()

        return content
            .background(
                shape
                    .fill(fill)
                    .overlay(
                        shape.stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(t.blurStrength > 0 ? 0.26 : 0.18),
                                    Color.white.opacity(0.06),
                                    Color.purple.opacity(t.blurStrength > 0 ? 0.28 : 0.18)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 0.9
                        )
                    )
            )
            .shadow(
                color: Color.black.opacity(0.32),
                radius: t.shadowRadius,
                x: 0,
                y: t.shadowRadius * 0.55
            )
    }
}

// MARK: - Liquid Glass (adaptive, no shimmer loops)

struct LiquidGlassCard<Content: View>: View {
    let cornerRadius: CGFloat
    let content: Content

    @EnvironmentObject private var performance: PerformanceProfile

    init(cornerRadius: CGFloat = 24, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    var body: some View {
        let t = performance.currentTuning
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        content
            .modifier(FrostCardModifier(cornerRadius: cornerRadius))
            .overlay(
                Group {
                    if t.allowHighlightOverlay && t.blurStrength > 0 {
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.22),
                                Color.white.opacity(0.0),
                                Color.white.opacity(0.16)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .blur(radius: 12)
                        .opacity(0.22)
                        .blendMode(.screen)
                        .mask(shape)
                    }
                }
            )
    }
}

// MARK: - Button Style (adaptive + COMPAT params)

struct PressableScaleStyle: ButtonStyle {
    var scaleAmount: CGFloat = 0.95
    var opacityAmount: Double = 0.96

    @EnvironmentObject private var performance: PerformanceProfile

    func makeBody(configuration: Configuration) -> some View {
        let t = performance.currentTuning
        let pressed = configuration.isPressed
        let allowAnim = t.animationLevel > 0

        return configuration.label
            .scaleEffect(pressed ? scaleAmount : 1.0)
            .opacity(pressed ? opacityAmount : 1.0)
            .offset(y: pressed ? 1 : 0)
            .shadow(
                color: Color.black.opacity(pressed ? 0.18 : 0.35),
                radius: pressed ? t.shadowRadius * 0.35 : t.shadowRadius,
                x: 0,
                y: pressed ? 2 : t.shadowRadius * 0.55
            )
            .animation(allowAnim ? AquireMotion.tap : nil, value: pressed)
    }
}

// MARK: - Restored compat components

struct IconGlassButton: View {
    let systemName: String
    var size: CGFloat = 26
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: size * 0.55, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: size, height: size)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.12))
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.25), lineWidth: 0.8)
                        )
                )
        }
        .buttonStyle(PressableScaleStyle())
    }
}

struct TagPill: View {
    let text: String
    var icon: String? = nil
    var tint: Color = .white

    var body: some View {
        HStack(spacing: 6) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 11, weight: .semibold))
            }
            Text(text)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .textCase(.uppercase)
                .tracking(0.7)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .foregroundColor(.white)
        .background(
            Capsule()
                .fill(tint.opacity(0.16))
                .overlay(
                    Capsule().stroke(tint.opacity(0.55), lineWidth: 0.9)
                )
        )
    }
}

struct StatusChip: View {
    enum Style { case neutral, accent, danger }

    let text: String
    var style: Style = .neutral

    private var borderColor: Color {
        switch style {
        case .neutral: return Color.white.opacity(0.35)
        case .accent:  return Color.purple.opacity(0.7)
        case .danger:  return Color.red.opacity(0.7)
        }
    }

    private var fillColor: Color {
        switch style {
        case .neutral: return Color.white.opacity(0.06)
        case .accent:  return Color.purple.opacity(0.2)
        case .danger:  return Color.red.opacity(0.18)
        }
    }

    var body: some View {
        Text(text.uppercased())
            .font(.system(size: 10, weight: .semibold, design: .rounded))
            .tracking(0.8)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundColor(.white.opacity(0.95))
            .background(
                RoundedRectangle(cornerRadius: 999, style: .continuous)
                    .fill(fillColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 999, style: .continuous)
                            .stroke(borderColor, lineWidth: 0.9)
                    )
            )
    }
}

struct StatusPill: View {
    let status: OrderStatus

    var body: some View {
        let label = statusLabel
        let tint = statusTint

        Text(label)
            .font(.caption2)
            .foregroundColor(tint)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .fill(tint.opacity(0.16))
                    .overlay(
                        Capsule().stroke(tint.opacity(0.55), lineWidth: 0.8)
                    )
            )
    }

    private var statusLabel: String {
        if let s = status as? any RawRepresentable,
           let raw = s.rawValue as? String {
            return raw
        }
        return String(describing: status)
    }

    private var statusTint: Color {
        let lower = statusLabel.lowercased()

        if lower.contains("process") { return .orange }
        if lower.contains("prepar") { return .yellow }
        if lower.contains("ship") { return .green }
        if lower.contains("deliver") { return .blue }
        if lower.contains("cancel") { return .red }

        return .white.opacity(0.8)
    }
}

// MARK: - Convenience Extensions (RESTORED overloads)

extension View {
    func aquireBackground() -> some View {
        self.background(AquireBackgroundView())
    }

    func frostCard(cornerRadius: CGFloat = 20) -> some View {
        self.modifier(FrostCardModifier(cornerRadius: cornerRadius))
    }

    func frostedPill(tint: Color) -> some View {
        self
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .fill(tint.opacity(0.18))
                    .overlay(
                        Capsule().stroke(tint.opacity(0.65), lineWidth: 0.8)
                    )
            )
            .foregroundColor(.white)
    }

    // Existing no-arg call
    func pressable() -> some View {
        self.buttonStyle(PressableScaleStyle())
    }

    // ✅ Compat overload: pressable(scaleAmount:opacityAmount:)
    func pressable(scaleAmount: CGFloat, opacityAmount: Double = 0.96) -> some View {
        self.buttonStyle(PressableScaleStyle(scaleAmount: scaleAmount, opacityAmount: opacityAmount))
    }

    // ✅ Compat overload: pressable(_ scaleAmount:)
    func pressable(_ scaleAmount: CGFloat) -> some View {
        self.buttonStyle(PressableScaleStyle(scaleAmount: scaleAmount, opacityAmount: 0.96))
    }

    func liquidGlass(cornerRadius: CGFloat = 20) -> some View {
        LiquidGlassCard(cornerRadius: cornerRadius) { self }
    }
}
