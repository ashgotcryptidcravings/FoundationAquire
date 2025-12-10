import SwiftUI

struct ContentView: View {
    @StateObject private var store = StoreModel()

    @AppStorage("Aquire_isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("Aquire_userEmail") private var storedEmail: String = ""
    @AppStorage("Aquire_debugOverlayEnabled") private var debugOverlayEnabled: Bool = false
    @AppStorage("Aquire_developerUnlocked") private var developerUnlocked: Bool = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            mainContent

            if debugOverlayEnabled {
                DebugOverlay()
                    .transition(.opacity)
                    .padding()
            }

            if developerUnlocked {
                debugToggleButton
            }
        }
        .environmentObject(store)
    }

    // MARK: - Main content switch

    @ViewBuilder
    private var mainContent: some View {
        if isLoggedIn {
            #if os(iOS)
            IOSTabRootView(userEmail: storedEmail)
            #else
            MacRootView(userEmail: storedEmail)
            #endif
        } else {
            // NEW CALL – no closure, just bindings
            LoginView(isLoggedIn: $isLoggedIn, storedEmail: $storedEmail)
        }
    }

    // MARK: - Debug toggle

    private var debugToggleButton: some View {
        IconGlassButton(
            systemName: debugOverlayEnabled ? "ladybug.fill" : "ladybug",
            size: 30
        ) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                debugOverlayEnabled.toggle()
            }
        }
        .padding(.top, 8)
        .padding(.trailing, 12)
    }
}

#if os(iOS)
// MARK: - iOS: TabView root

struct IOSTabRootView: View {
    let userEmail: String
    @EnvironmentObject var store: StoreModel

    var body: some View {
        TabView {
            HomeView(userEmail: userEmail)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Featured")
                }

            InfoView(userEmail: userEmail)
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }

            BrowseView(products: store.visibleProducts)
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Browse")
                }

            AcquiredView()
                .tabItem {
                    Image(systemName: "shippingbox.fill")
                    Text("Acquired")
                }

            OrdersView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.portrait")
                    Text("Orders")
                }
        }
        .accentColor(.purple)
    }
}
#endif

#if os(macOS)
// MARK: - macOS: Sidebar root

@available(macOS 12.0, *)
struct MacRootView: View {
    let userEmail: String
    @EnvironmentObject var store: StoreModel

    @State private var selection: Tab? = .featured

    // Nested enum to avoid global name conflicts
    enum Tab: String, CaseIterable, Identifiable {
        case featured
        case info
        case browse
        case acquired
        case orders

        var id: String { rawValue }

        var title: String {
            switch self {
            case .featured: return "Featured"
            case .info:     return "Info"
            case .browse:   return "Browse"
            case .acquired: return "Acquired"
            case .orders:   return "Orders"
            }
        }

        var systemImage: String {
            switch self {
            case .featured: return "star.fill"
            case .info:     return "info.circle"
            case .browse:   return "square.grid.2x2"
            case .acquired: return "shippingbox.fill"
            case .orders:   return "list.bullet.rectangle.portrait"
            }
        }
    }

    var body: some View {
        NavigationView {
            sidebar
            contentArea
        }
        .navigationTitle("")
    }

    // MARK: Sidebar

    private var sidebar: some View {
        List(selection: $selection) {
            ForEach(Tab.allCases) { tab in
                HStack(spacing: 8) {
                    Image(systemName: tab.systemImage)
                    Text(tab.title)
                }
                .tag(tab as Tab?)
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 200, idealWidth: 220, maxWidth: 260)
        .background(Color(red: 0.05, green: 0.05, blue: 0.05))
    }

    // MARK: Content area

    @ViewBuilder
    private var contentArea: some View {
        switch selection ?? .featured {
        case .featured:
            HomeView(userEmail: userEmail)

        case .info:
            InfoView(userEmail: userEmail)

        case .browse:
            BrowseView(products: store.visibleProducts)

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
}
#endif
