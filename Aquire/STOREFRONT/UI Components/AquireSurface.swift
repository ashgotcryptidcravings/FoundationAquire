//
//  AquireSurface.swift
//  Aquire
//
//  Created by Zero on 12/15/25.
//


//
//  AquireSurface.swift
//  Aquire
//

import SwiftUI

struct AquireSurface<Content: View>: View {
    let cornerRadius: CGFloat
    let padding: CGFloat
    let content: Content

    @EnvironmentObject private var performance: PerformanceProfile

    init(
        cornerRadius: CGFloat = 22,
        padding: CGFloat = 16,
        @ViewBuilder content: () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.content = content()
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    Color.white.opacity(
                        performance.currentTuning.blurStrength > 0 ? 0.12 : 0.06
                    )
                )

            content
                .padding(padding)
        }
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(Color.white.opacity(0.18), lineWidth: 0.8)
        )
        .shadow(
            color: Color.black.opacity(
                performance.currentTuning.shadowStrength * 0.25
            ),
            radius: performance.currentTuning.shadowStrength * 12,
            y: performance.currentTuning.shadowStrength * 6
        )
    }
}