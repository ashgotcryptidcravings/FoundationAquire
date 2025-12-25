//
//  LiquidGlass.swift
//  Aquire
//
//  Created by Zero on 12/15/25.
//


import SwiftUI

extension View {
    func liquidGlass() -> some View {
        self
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}