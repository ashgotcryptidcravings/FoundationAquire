//
//  AquireHeroCard.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import SwiftUI

struct AquireHeroCard: View {
    let title: String
    let subtitle: String
    let icon: String

    @EnvironmentObject private var gates: FeatureGates

    var body: some View {
        AquireSurface(cornerRadius: 28, padding: 18) {
            HStack(alignment: .center, spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 54, height: 54)

                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white.opacity(0.92))
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text(subtitle)
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(2)
                }

                Spacer()

                if gates.gates.allowHighlightOverlay {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        }
    }
}