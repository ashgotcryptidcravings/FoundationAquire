//
//  EmptyStateCard.swift
//  Aquire
//

import SwiftUI

struct EmptyStateCard: View {
    let icon: String
    let title: String
    let message: String

    var body: some View {
        AquireSurface {
            VStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(.white.opacity(0.7))

                Text(title)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text(message)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.65))
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
