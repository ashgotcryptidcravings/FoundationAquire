//
//  UIHelpers.swift
//  Aquire
//

import SwiftUI

// MARK: - Background

struct AquireBackgroundView: View {
    @EnvironmentObject private var performance: PerformanceProfile

    var body: some View {
        LinearGradient(
            colors: [
                .black,
                Color.purple.opacity(performance.currentTuning.blurStrength * 0.6)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

extension View {
    func aquireBackground() -> some View {
        self.background(AquireBackgroundView())
    }
}

// MARK: - Pressable

struct PressableModifier: ViewModifier {
    let scale: CGFloat

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .animation(.easeOut(duration: 0.2), value: scale)
    }
}

extension View {
    func pressable(_ scale: CGFloat = 0.97) -> some View {
        modifier(PressableModifier(scale: scale))
    }
}
