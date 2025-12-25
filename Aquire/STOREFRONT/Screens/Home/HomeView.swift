//
//  HomeView.swift
//  Aquire
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: StoreModel
    @EnvironmentObject private var router: StorefrontRouter
    @EnvironmentObject private var performance: PerformanceProfile
    @EnvironmentObject private var telemetry: Telemetry

    @State private var selectedKey: String? = nil

    private var allowMotion: Bool { performance.currentTuning.animationLevel > 0 }

    private var featured: [Product] { ProductCatalog.featured }
    private var chipsets: [Product] { ProductCatalog.chipsets }

    private var wishlistProducts: [Product] {
        Array(store.wishlist).compactMap { ProductCatalog.product(for: $0) }
    }

    private var acquiredProducts: [Product] {
        Array(store.acquired.keys).compactMap { ProductCatalog.product(for: $0) }
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {

                // Hero (tappable)
                Button {
                    telemetry.log("home_hero_tap", source: "foundation_hub")
                    selectedKey = "foundation_hub"
                } label: {
                    AquireHeroCard(
                        title: "Foundation Hub",
                        subtitle: "Command surface for the Foundation ecosystem.",
                        systemImage: "sparkles"
                    )
                }
                .buttonStyle(.plain)
                .pressable(0.985)

                // Stats
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ], spacing: 12) {

                    AquireStatTile(title: "Wishlist", value: "\(store.wishlist.count)", systemImage: "bookmark")
                    AquireStatTile(title: "Acquired", value: "\(store.acquired.count)", systemImage: "checkmark.seal")
                    AquireStatTile(title: "Orders", value: "\(store.orders.count)", systemImage: "shippingbox")
                    AquireStatTile(title: "Tier", value: performance.tier.rawValue.capitalized, systemImage: "gauge.with.dots.needle.50percent")
                }
                .animation(allowMotion ? .easeOut(duration: 0.25) : nil, value: store.wishlist.count)
                .animation(allowMotion ? .easeOut(duration: 0.25) : nil, value: store.acquired.count)
                .animation(allowMotion ? .easeOut(duration: 0.25) : nil, value: store.orders.count)

                // Quick Actions
                AquireSurface(cornerRadius: 24, padding: 14) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quick Actions")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))

                        HStack(spacing: 10) {
                            HomeQuickActionButton(title: "Browse", icon: "square.grid.2x2") {
                                telemetry.log("home_action", source: "browse")
                                router.browse()
                            }
                            HomeQuickActionButton(title: "Chipsets", icon: "cpu") {
                                telemetry.log("home_action", source: "chipsets")
                                router.browse()
                                // (optional) you can add a router category filter later
                            }
                            HomeQuickActionButton(title: "Orders", icon: "shippingbox") {
                                telemetry.log("home_action", source: "orders")
                                router.orders()
                            }
                        }
                    }
                }

                // Rails
                ProductRail(
                    title: "Featured",
                    subtitle: "Top picks in your catalog",
                    products: featured
                ) { p in
                    if let key = ProductCatalog.key(for: p) {
                        telemetry.log("home_featured_tap", source: key)
                        selectedKey = key
                    }
                }

                ProductRail(
                    title: "Foundation Silicon",
                    subtitle: "Chipsets + compute tiles",
                    products: chipsets
                ) { p in
                    if let key = ProductCatalog.key(for: p) {
                        telemetry.log("home_chipset_tap", source: key)
                        selectedKey = key
                    }
                }

                if !wishlistProducts.isEmpty {
                    ProductRail(
                        title: "Wishlist",
                        subtitle: "Saved for later",
                        products: Array(wishlistProducts.prefix(12))
                    ) { p in
                        if let key = ProductCatalog.key(for: p) {
                            telemetry.log("home_wishlist_rail_tap", source: key)
                            selectedKey = key
                        }
                    }
                }

                if !acquiredProducts.isEmpty {
                    ProductRail(
                        title: "Acquired",
                        subtitle: "Your owned devices",
                        products: Array(acquiredProducts.prefix(12))
                    ) { p in
                        if let key = ProductCatalog.key(for: p) {
                            telemetry.log("home_acquired_rail_tap", source: key)
                            selectedKey = key
                        }
                    }
                }

                Spacer(minLength: 12)
            }
            .padding(16)
        }
        .background(AquireBackdrop().ignoresSafeArea())
        .sheet(item: $selectedKey) { key in
            if let product = ProductCatalog.product(for: key) {
                ProductDetailView(product: product, showsCloseButton: true)
                    .environmentObject(store)
                    .environmentObject(telemetry)
            } else {
                VStack(spacing: 12) {
                    Text("Missing Product")
                        .font(.headline)
                    Text("No catalog entry for key: \(key)")
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
        }
        .onAppear {
            telemetry.log("screen_show", source: "Home")
        }
    }
}

// MARK: - Product Rail

struct ProductRail: View {
    let title: String
    let subtitle: String?
    let products: [Product]
    let onTap: (Product) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white.opacity(0.95))

                if let subtitle {
                    Text(subtitle)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.leading, 6)
                }

                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(products, id: \.name) { p in
                        Button { onTap(p) } label: {
                            ProductCard(product: p)
                                .frame(width: 320)
                        }
                        .buttonStyle(.plain)
                        .pressable(0.99)
                    }
                }
                .padding(.horizontal, 2)
            }
        }
    }
}

// MARK: - Quick Action Button

private struct HomeQuickActionButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white.opacity(0.9))
                Text(title)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
            }
            .foregroundColor(.white.opacity(0.9))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.10))
                    .overlay(Capsule().stroke(Color.white.opacity(0.18), lineWidth: 0.8))
            )
        }
        .buttonStyle(.plain)
        .pressable(0.98)
    }
}
