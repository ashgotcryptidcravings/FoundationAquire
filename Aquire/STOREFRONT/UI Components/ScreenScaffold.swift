//
//  ScreenScaffold.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import SwiftUI

struct ScreenScaffold<Content: View>: View {
    let title: String
    let subtitle: String?
    let content: Content

    @EnvironmentObject private var profile: AppProfile
    @EnvironmentObject private var telemetry: Telemetry

    init(_ title: String, subtitle: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            content
            Spacer(minLength: 0)
        }
        .padding(18)
        .onAppear {
            telemetry.log("screen_show", "\(title) | exp=\(profile.experience.rawValue)")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)

            if let subtitle {
                Text(subtitle)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
        }
    }
}