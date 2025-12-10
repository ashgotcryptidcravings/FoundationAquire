import SwiftUI

@available(macOS 12.0, iOS 15.0, *)
struct ContentView: View {
    @StateObject private var store = StoreModel()
    @AppStorage("Aquire_isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("Aquire_userEmail") private var storedEmail: String = ""

    var body: some View {
        Group {
            if isLoggedIn {
                #if os(macOS)
                MacRootView(userEmail: storedEmail)
                #else
                IOSTabRootView(userEmail: storedEmail)
                #endif
            } else {
                LoginView { email, _ in
                    storedEmail = email
                    isLoggedIn = true
                }
            }
        }
        .accentColor(.purple)
        .environmentObject(store)
    }
}

// MARK: - iOS: TabView

@available(iOS 15.0, *)
struct IOSTabRootView: View {
    let userEmail: String

    var body: some View {
        TabView {
            HomeView(product: products[0], userEmail: userEmail)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Featured")
                }

            InfoView(userEmail: userEmail)
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }

            BrowseView(products: products)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                }

            WishlistView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Wishlist")
                }

            AcquiredView()
                .tabItem {
                    Image(systemName: "shippingbox.fill")
                    Text("Acquired")
                }

            if #available(macOS 13.0, iOS 16.0, *) {
                OrdersView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle.portrait")
                        Text("Orders")
                    }
            }
        }
    }
}

// MARK: - macOS: Sidebar layout

@available(macOS 12.0, *)
struct MacRootView: View {
    enum MacTab: String, CaseIterable, Identifiable {
        case featured
        case info
        case browse
        case wishlist
        case acquired
        case orders

        var id: String { rawValue }

        var label: String {
            switch self {
            case .featured: return "Featured"
            case .info:     return "Info"
            case .browse:   return "Browse"
            case .wishlist: return "Wishlist"
            case .acquired: return "Acquired"
            case .orders:   return "Orders"
            }
        }

        var systemImage: String {
            switch self {
            case .featured: return "star.fill"
            case .info:     return "info.circle"
            case .browse:   return "magnifyingglass"
            case .wishlist: return "star"
            case .acquired: return "shippingbox.fill"
            case .orders:   return "list.bullet.rectangle.portrait"
            }
        }
    }

    let userEmail: String
    @EnvironmentObject var store: StoreModel
    @State private var selection: MacTab = .featured

    var body: some View {
        HStack(spacing: 0) {
            sidebar
            Divider()
                .background(Color.white.opacity(0.1))
            contentArea
        }
        .background(Color.black.ignoresSafeArea())
    }

    // MARK: - Sidebar

    private var sidebar: some View {
        VStack(alignment: .leading, spacing: 12) {
            // App title + email
            VStack(alignment: .leading, spacing: 4) {
                Text("Aquire")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Text(userEmail)
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.6))
            }
            .padding(.top, 18)
            .padding(.horizontal, 16)

            // Level / XP
            HStack(spacing: 6) {
                Text("Level \(store.level)")
                    .font(.system(size: 11, weight: .semibold))
                Text("·")
                Text("\(store.xp) XP")
            }
            .foregroundColor(.purple.opacity(0.9))
            .padding(.horizontal, 16)

            Divider()
                .background(Color.white.opacity(0.1))
            .padding(.vertical, 4)

            // Tabs
            VStack(alignment: .leading, spacing: 4) {
                ForEach(MacTab.allCases) { tab in
                    Button {
                        selection = tab
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: tab.systemImage)
                                .frame(width: 16)
                            Text(tab.label)
                                .font(.system(size: 13, weight: .medium))
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(selection == tab
                                      ? Color.white.opacity(0.12)
                                      : Color.clear)
                        )
                        .foregroundColor(selection == tab ? .white : .white.opacity(0.7))
                        .contentShape(Rectangle()) // whole row tappable
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 8)

            Spacer()
        }
        .frame(width: 200)
        .background(Color(red: 0.05, green: 0.05, blue: 0.05))
    }

    // MARK: - Content

    @ViewBuilder
    private var contentArea: some View {
        ZStack {
            Color.black

            switch selection {
            case .featured:
                HomeView(product: products[0], userEmail: userEmail)

            case .info:
                InfoView(userEmail: userEmail)

            case .browse:
                BrowseView(products: products)

            case .wishlist:
                WishlistView()

            case .acquired:
                AcquiredView()

            case .orders:
                if #available(macOS 13.0, *) {
                    OrdersView()
                } else {
                    VStack {
                        Text("Orders view requires macOS 13 or later.")
                            .foregroundColor(.white.opacity(0.8))
                            .padding()
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea() // inside main HStack
    }
}
