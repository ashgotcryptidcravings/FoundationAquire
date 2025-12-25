//
//  AdminFrontShellView.swift
//  Aquire
//
//  Created by Zero on 12/11/25.
//


import SwiftUI

/// Top-level surface for admin / developer tools.
/// Right now this is just a simple wrapper around AdminPanelView
/// inside a navigation container.
struct AdminFrontShellView: View {
    @EnvironmentObject private var store: StoreModel

    var body: some View {
        NavigationStack {
            AdminPanelView()
                .navigationTitle("AdminFront")
        }
    }
}