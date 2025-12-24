//
//  ClientFrontShellView.swift
//  Aquire
//
//  Created by Zero on 12/11/25.
//


import SwiftUI

/// Wrapper around the existing "main app" surface.
/// For now this simply forwards into your existing ContentView.
/// Later you can split ContentView into smaller HOMEFRONT/CLIENTFRONT screens.
struct ClientFrontShellView: View {
    var body: some View {
        ContentView()
    }
}