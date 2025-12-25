//
//  AquireProductRow.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import SwiftUI

struct AquireProductRow: View {
    let product: Product
    let trailingText: String?

    init(product: Product, trailingText: String? = nil) {
        self.product = product
        self.trailingText = trailingText
    }

    var body: some View {
        AquireSurface {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 40, height: 40)

                    Image(systemName: product.imageSystemName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.9))
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(product.name)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)

                    Text(product.category)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.65))
                }

                Spacer()

                if let trailingText {
                    Text(trailingText)
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.85))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.10))
                                .overlay(Capsule().stroke(Color.white.opacity(0.20), lineWidth: 0.8))
                        )
                } else {
                    Text(product.price, format: .currency(code: "USD"))
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.85))
                }
            }
        }
    }
}