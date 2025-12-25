//
//  PatchNotesView.swift
//  Aquire
//

import SwiftUI

struct PatchNotesView: View {
    let releases: [PatchRelease]

    var body: some View {
        ScreenScaffold("Patch Notes", subtitle: "What’s new in Aquire.", source: "patch_notes") {
            VStack(spacing: 14) {
                ForEach(releases) { r in
                    AquireSurface(cornerRadius: 24, padding: 16) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("v\(r.version)")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                Spacer()
                                Text(r.date)
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white.opacity(0.65))
                            }

                            ForEach(r.highlights, id: \.self) { line in
                                Text("• \(line)")
                                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                    }
                }
            }
        }
    }
}
