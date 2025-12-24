//
//  ScreenScaffold.swift
//  Aquire
//

import SwiftUI

struct ScreenScaffold<Content: View>: View {
    private let title: String
    private let subtitle: String?
    private let source: String?
    private let content: Content

    init(
        _ title: String,
        subtitle: String? = nil,
        source: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.source = source
        self.content = content()
    }

    var body: some View {
        ScrollView {
            // Use LazyVStack to avoid constructing all child views immediately.
            LazyVStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    if let subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)

                content
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
            }
        }
        .background(AquireBackdrop().ignoresSafeArea())
        .accessibilityIdentifier(source ?? title)
    }
}

struct AquireBackdrop: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color.black,
                Color.purple.opacity(0.35),
                Color.black
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}