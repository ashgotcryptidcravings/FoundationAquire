//
//  ProductDockBar.swift
//  Aquire
//
//  Created by Zero on 12/15/25.
//


import SwiftUI

struct ProductDockBar: View {
    let isOwned: Bool
    let isWishlisted: Bool
    let canAct: Bool
    let onToggleWishlist: () -> Void
    let onBuy: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Button(action: onToggleWishlist) {
                Label(isWishlisted ? "Saved" : "Save",
                      systemImage: isWishlisted ? "bookmark.fill" : "bookmark")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(.white.opacity(0.92))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.10))
                        .overlay(Capsule().stroke(Color.white.opacity(0.18), lineWidth: 0.9))
                )
            }
            .buttonStyle(.plain)
            .disabled(!canAct)
            .opacity(canAct ? 1 : 0.55)

            Button(action: onBuy) {
                Label(isOwned ? "Owned" : "Buy",
                      systemImage: isOwned ? "checkmark.seal.fill" : "bag.fill")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(.white.opacity(0.95))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(isOwned ? 0.10 : 0.18))
                        .overlay(Capsule().stroke(Color.white.opacity(0.22), lineWidth: 0.9))
                )
            }
            .buttonStyle(.plain)
            .disabled(!canAct || isOwned)
            .opacity((!canAct || isOwned) ? 0.55 : 1)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.black.opacity(0.55))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.white.opacity(0.10), lineWidth: 0.8)
                )
        )
    }
}