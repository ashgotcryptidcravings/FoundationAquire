//
//  ModelViewerSheet.swift
//  Aquire
//
//  Created by Zero on 12/15/25.
//


import SwiftUI
import RealityKit

/// Full-screen-ish sheet for viewing a USDZ model from the app bundle.
/// Pass `modelName` without extension (ex: "OnyxModule").
struct ModelViewerSheet: View {
    let modelName: String
    @Environment(\.dismiss) private var dismiss

    private var usdzName: String { "\(modelName).usdz" }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 14) {
                header

                ZStack {
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(Color.white.opacity(0.06))

                    Model3D(named: usdzName, bundle: .main) { phase in
                        switch phase {
                        case .success(let model):
                            model
                                .resizable()
                                .scaledToFit()
                                .padding(18)

                        case .failure:
                            fallback

                        case .empty:
                            ProgressView()
                                .progressViewStyle(.circular)
                        @unknown default:
                            fallback
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 18)
            }
            .padding(.top, 10)
        }
    }

    private var header: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(modelName)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("3D Preview")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.65))
            }

            Spacer()

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.85))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 6)
    }

    private var fallback: some View {
        VStack(spacing: 10) {
            Image(systemName: "cube.transparent")
                .font(.system(size: 42, weight: .semibold))
                .foregroundStyle(.white.opacity(0.8))

            Text("Couldn’t load \(usdzName)")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(.white.opacity(0.8))

            Text("Make sure the file is in the app target (Copy Bundle Resources).")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.55))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding(20)
    }
}