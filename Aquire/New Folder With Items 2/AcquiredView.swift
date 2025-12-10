import SwiftUI

struct AcquiredView: View {
    @EnvironmentObject var store: StoreModel

    @State private var selectedProduct: Product?

    var body: some View {
        #if os(iOS)
        iOSBody
        #else
        macOSBody
        #endif
    }

    // MARK: - iOS Body

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
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(store.acquiredProducts) { product in
                                iOSRow(for: product)
                            }
                        }
                        .padding(16)
                    }
                }
            }
            .navigationTitle("Acquired")
        }
        .sheet(item: $selectedProduct) { product in
            PurchaseInfoView(product: product)
                .environmentObject(store)
        }
    }

    // MARK: - macOS Body

    private var macOSBody: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if store.acquiredProducts.isEmpty {
                Text("No items acquired yet.\nBrowse the store to begin.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.8))
                    .padding()
            } else {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Acquired")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)

                    Text("Devices and modules you’ve already brought into your Foundation stack.")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.horizontal, 24)

                    ScrollView {
                        LazyVStack(spacing: 10) {
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
        .sheet(item: $selectedProduct) { product in
            PurchaseInfoView(product: product)
                .environmentObject(store)
        }
    }

    // MARK: - Rows

    private func iOSRow(for product: Product) -> some View {
        Button {
            selectedProduct = product
        } label: {
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

                    Text("Qty: \(store.quantity(for: product))")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 12))

                    if let order = store.lastOrder(for: product) {
                        Text(order.status.displayName)
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 11))
                    }
                }

                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(red: 0.09, green: 0.09, blue: 0.09))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func macOSRow(for product: Product) -> some View {
        Button {
            selectedProduct = product
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

                    Text("Qty: \(store.quantity(for: product))")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 11))

                    if let order = store.lastOrder(for: product) {
                        Text(order.status.displayName)
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 11))
                    }
                }

                Spacer()
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(red: 0.08, green: 0.08, blue: 0.08))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Purchase Info Sheet

struct PurchaseInfoView: View {
    let product: Product
    @EnvironmentObject var store: StoreModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                // Top bar with close button
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)

                // Title
                Text(product.name)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 4)

                // Content
                if let order = store.lastOrder(for: product) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Last Order")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("Status: \(order.status.displayName)")
                            .foregroundColor(.white.opacity(0.9))

                        Text("Ordered: \(formatted(order.date))")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                } else {
                    Text("No order record found for this item.")
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal, 20)
                }

                Spacer()
            }
        }
    }

    private func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
