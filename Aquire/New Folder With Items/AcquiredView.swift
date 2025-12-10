import SwiftUI

struct AcquiredView: View {
    @EnvironmentObject var store: StoreModel

    @State private var selectedProductForInfo: Product?
    @State private var showingInfo = false

    var body: some View {
        #if os(iOS)
        iOSBody
        #else
        macOSBody
        #endif
    }

    private var headerText: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(store.acquiredProducts.count) item(s) acquired")
            Text("Total spent \(store.totalSpent, format: .currency(code: "USD"))")
        }
        .foregroundColor(.white.opacity(0.7))
    }

    // MARK: - iOS

    private var iOSBody: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                if store.acquiredProducts.isEmpty {
                    Text("No items acquired yet.\nBrowse the store to begin.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding()
                } else {
                    List {
                        Section(header: headerText) {
                            ForEach(store.acquiredProducts) { product in
                                iOSRow(for: product)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Acquired")
            .sheet(isPresented: $showingInfo) {
                if let product = selectedProductForInfo {
                    PurchaseInfoView(product: product)
                        .environmentObject(store)
                }
            }
        }
    }

    private func iOSRow(for product: Product) -> some View {
        HStack {
            Image(systemName: product.imageSystemName)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundColor(.purple)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))

                Text("\(store.quantity(for: product)) × \(product.price, format: .currency(code: "USD"))")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.system(size: 13))
            }

            Spacer()
        }
        .listRowBackground(Color.black)
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            Button {
                store.addOne(product)
                store.createOrder(for: product)
            } label: {
                Label("Duplicate", systemImage: "plus.square.on.square")
            }
            .tint(.purple)

            Button {
                selectedProductForInfo = product
                showingInfo = true
            } label: {
                Label("Details", systemImage: "info.circle")
            }
            .tint(.gray)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                store.removeAll(product)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }

    // MARK: - macOS

    private var macOSBody: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if store.acquiredProducts.isEmpty {
                Text("No items acquired yet.\nBrowse the store to begin.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.8))
                    .padding()
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Acquired")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)

                    headerText
                        .padding(.horizontal, 24)

                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(store.acquiredProducts) { product in
                                macOSRow(for: product)
                            }
                        }
                        .padding(16)
                        .frame(maxWidth: 700)
                        .frame(maxWidth: .infinity)
                    }

                    Spacer(minLength: 0)
                }
            }
        }
        .sheet(isPresented: $showingInfo) {
            if let product = selectedProductForInfo {
                PurchaseInfoView(product: product)
                    .environmentObject(store)
            }
        }
    }

    private func macOSRow(for product: Product) -> some View {
        Button {
            selectedProductForInfo = product
            showingInfo = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: product.imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.purple)

                VStack(alignment: .leading, spacing: 3) {
                    Text(product.name)
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .semibold))

                    Text("\(store.quantity(for: product)) × \(product.price, format: .currency(code: "USD"))")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 12))
                }

                Spacer()
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(red: 0.08, green: 0.08, blue: 0.08))
            )
        }
        .buttonStyle(PlainButtonStyle())
        .contextMenu {
            Button("Duplicate") {
                store.addOne(product)
                store.createOrder(for: product)
            }
            Button("Remove All", role: .destructive) {
                store.removeAll(product)
            }
        }
    }
}

// MARK: - Purchase Info Sheet

struct PurchaseInfoView: View {
    let product: Product
    @EnvironmentObject var store: StoreModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                Text(product.name)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)

                if let order = store.lastOrder(for: product) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Last Order")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("Status: \(order.status.displayName)")
                            .foregroundColor(.white.opacity(0.9))

                        Text("Ordered: \(order.date.formatted(date: .abbreviated, time: .shortened))")
                            .foregroundColor(.white.opacity(0.7))
                    }
                } else {
                    Text("No order record found for this item.")
                        .foregroundColor(.white.opacity(0.7))
                }

                Spacer()
            }
            .padding()
        }
    }
}
