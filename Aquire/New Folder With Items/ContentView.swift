import SwiftUI

@available(macOS 12.0, iOS 15.0, *)
struct ContentView: View {
    @StateObject private var store = StoreModel()
    @AppStorage("Aquire_isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("Aquire_userEmail") private var storedEmail: String = ""

    var body: some View {
        Group {
            if isLoggedIn {
                TabView {
                    HomeView(product: products[0], userEmail: storedEmail)
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text("Featured")
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

                    if #available(macOS 13.0, *) {
                        OrdersView()
                            .tabItem {
                                Image(systemName: "list.bullet.rectangle.portrait")
                                Text("Orders")
                            }
                    } else {
                        // Fallback on earlier versions
                    }
                }
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
