//
//  AquireHeroCard.swift
//  Aquire
//

import SwiftUI

struct AquireHeroCard<Content: View>: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let content: Content

    init(
        title: String,
        subtitle: String,
        systemImage: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.content = content()
    }

    /// Convenience: lets you call it with NO trailing closure.
    init(
        title: String,
        subtitle: String,
        systemImage: String
    ) where Content == EmptyView {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.content = EmptyView()
    }

    var body: some View {
        AquireSurface(cornerRadius: 28, padding: 18) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Color.white.opacity(0.10))
                            .frame(width: 54, height: 54)

                        Image(systemName: systemImage)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white.opacity(0.92))
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Text(subtitle)
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                            .lineLimit(2)
                    }

                    Spacer()
                }

                content
            }
        }
    }
}
