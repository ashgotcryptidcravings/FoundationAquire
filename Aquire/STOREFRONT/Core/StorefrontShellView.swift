//
//  StorefrontShellView.swift
//  Aquire
//
//  Created by Zero on 12/12/25.
//


import SwiftUI

struct StorefrontShellView: View {
    @EnvironmentObject private var store: StoreModel
    @EnvironmentObject private var router: StorefrontRouter
    @EnvironmentObject private var performance: PerformanceProfile
    @EnvironmentObject private var profile: AppProfile
    @EnvironmentObject private var gates: FeatureGates
    @EnvironmentObject private var telemetry: Telemetry

    var body: some View {
        Group {
            #if os(tvOS)
            tvOSBody
            #else
            standardBody
            #endif
        }
        .onAppear {
            gates.recompute(performance: performance, profile: profile)
            telemetry.log("storefront_enter", "route=\(router.selected.rawValue)")
        }
        .onChange(of: router.selected) { _, newValue in
            telemetry.log("route_change", newValue.rawValue)
        }
        .onChange(of: profile.experience) { _, _ in
            gates.recompute(performance: performance, profile: profile)
        }
        .onChange(of: performance.systemThrottleActive) { _, _ in
            gates.recompute(performance: performance, profile: profile)
        }
    }

    // MARK: - iOS / macOS

    private var standardBody: some View {
        NavigationSplitView {
            List(selection: $router.selected) {
                ForEach(filteredRoutes) { route in
                    Label(route.title, systemImage: route.systemIcon)
                        .tag(route)
                }
            }
            .navigationTitle("Aquire")
        } detail: {
            StorefrontDetailView(route: router.selected)
        }
    }

    // MARK: - tvOS

    private var tvOSBody: some View {
        // tvOS rule: no iOS-style tabs.
        // This is a simple shell for now — we’ll replace it with your cinematic rails.
        StorefrontDetailView(route: router.selected)
    }

    // MARK: - Route visibility (hide stuff until meaningful)

    private var filteredRoutes: [StorefrontRoute] {
        // Your rule: wishlist/acquired/orders hidden until there’s a reason.
        let hasWishlist = !store.wishlist.isEmpty
        let hasAcquired = !store.acquired.isEmpty
        let hasOrders = !store.orders.isEmpty

        return StorefrontRoute.allCases.filter { route in
            switch route {
            case .wishlist:
                return hasWishlist
            case .acquired:
                return hasAcquired
            case .orders:
                return hasOrders
            default:
                return true
            }
        }
    }
}