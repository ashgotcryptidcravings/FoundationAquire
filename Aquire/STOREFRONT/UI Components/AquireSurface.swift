//
//  AquireSurface.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import SwiftUI

struct AquireSurface<Content: View>: View {
    let cornerRadius: CGFloat
    let padding: CGFloat
    let content: Content

    @EnvironmentObject private var gates: FeatureGates

    init(cornerRadius: CGFloat = 22, padding: CGFloat = 16, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.content = content()
    }

    var body: some View {
        content
            .padding(padding)
            .background(background)
            .overlay(border)
            .shadow(color: .black.opacity(gates.gates.allowShadows ? 0.35 : 0.0),
                    radius: gates.gates.allowShadows ? 18 : 0,
                    x: 0,
                    y: gates.gates.allowShadows ? 10 : 0)
    }

    private var background: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(Color.white.opacity(0.08))

            if gates.gates.allowHeavyBlur {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .opacity(0.75)
            }

            if gates.gates.allowHighlightOverlay {
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.18),
                        Color.white.opacity(0.04),
                        Color.clear
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .blendMode(.screen)
            }
        }
    }

    private var border: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .stroke(Color.white.opacity(0.18), lineWidth: 0.9)
    }
}