//
//  AquireHeader.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import SwiftUI

struct AquireHeader: View {
    let title: String
    let subtitle: String?

    @EnvironmentObject private var gates: FeatureGates

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.white)

            if let subtitle {
                Text(subtitle)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.72))
            }

            if gates.gates.allowHighlightOverlay {
                Divider()
                    .background(Color.white.opacity(0.16))
                    .padding(.top, 2)
            }
        }
        .padding(.bottom, 6)
    }
}