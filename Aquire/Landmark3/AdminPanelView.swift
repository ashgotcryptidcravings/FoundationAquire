import SwiftUI

@available(macOS 13.0, *)
struct AdminPanelView: View {
    @EnvironmentObject var store: StoreModel
    @Environment(\.dismiss) private var dismiss

    @State private var selectedProduct: Product?

    /// In a real app this would be fetched from a backend.
    /// For now we use the global `products` constant.
    private var allProducts: [Product] {
        products
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                List {
                    Section("Products") {
                        ForEach(allProducts) { product in
                            Button {
                                selectedProduct = product
                            } label: {
                                productRow(for: product)
                            }
                            .buttonStyle(.plain)
                            .listRowBackground(Color.black)
                        }
                    }

                    Section("Summary") {
                        HStack {
                            Text("Visible")
                            Spacer()
                            Text("\(store.visibleProducts.count)")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        HStack {
                            Text("Wishlist")
                            Spacer()
                            Text("\(store.wishlistProducts.count)")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        HStack {
                            Text("Acquired")
                            Spacer()
                            Text("\(store.acquiredProducts.count)")
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                }
                .environment(\.defaultMinListRowHeight, 36)
                List {
                    Section("Products") {
                        // ...
                    }

                    Section("Summary") {
                        // ...
                    }
                }
                .environment(\.defaultMinListRowHeight, 36)
                .listStyle(.inset)              // ← was .insetGrouped
                .scrollContentBackground(.hidden)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Admin Panel")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
            .sheet(item: $selectedProduct) { product in
                ProductAdminDetailView(product: product)
                    .environmentObject(store)
            }
        }
    }

    // MARK: - Row

    private func productRow(for product: Product) -> some View {
        HStack(spacing: 12) {
            // Tiny icon / pill
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.white.opacity(0.06))

                Image(systemName: product.imageSystemName)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.purple)
            }
            .frame(width: 28, height: 28)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(product.name)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .semibold))

                    if store.isHidden(product) {
                        TagPill(text: "HIDDEN", tint: .red)
                    }

                    if let badge = store.badge(for: product) {
                        TagPill(text: badge.uppercased(),
                                tint: Color.purple.opacity(0.9))
                    }

                    if store.featuredProduct?.id == product.id {
                        TagPill(text: "FEATURED",
                                tint: Color.blue.opacity(0.9))
                    }
                }

                Text(product.category)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }

            Spacer()

            Text(product.price, format: .currency(code: "USD"))
                .foregroundColor(.white.opacity(0.8))
                .font(.caption)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Tiny pill view

private struct TagPill: View {
    let text: String
    let tint: Color

    var body: some View {
        Text(text)
            .font(.caption2)
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(
                Capsule().fill(tint.opacity(0.18))
            )
            .foregroundColor(tint)
    }
}

// MARK: - Per-product detail editor

struct ProductAdminDetailView: View {
    let product: Product

    @EnvironmentObject var store: StoreModel
    @Environment(\.dismiss) private var dismiss

    @State private var isFeatured: Bool = false
    @State private var isHidden: Bool = false
    @State private var badgeText: String = ""

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                header

                VStack(alignment: .leading, spacing: 12) {
                    Toggle("Featured on Home", isOn: $isFeatured)
                        .toggleStyle(.switch)
                        .tint(.purple)

                    Toggle("Hide from Browse", isOn: $isHidden)
                        .toggleStyle(.switch)
                        .tint(.purple)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Badge Label")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))

                        TextField("e.g. LABS, PROTOTYPE, BETA", text: $badgeText)
                            .textFieldStyle(.plain)
                            .padding(10)
                            .background(Color.white.opacity(0.08))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }

                Spacer()

                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white.opacity(0.7))

                    Spacer()

                    Button {
                        applyChanges()
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Save Changes")
                        }
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.horizontal, 22)
                        .padding(.vertical, 9)
                        .background(
                            Capsule().fill(Color.purple)
                        )
                        .foregroundColor(.white)
                    }
                }
            }
            .padding(24)
        }
        .onAppear(perform: loadCurrentValues)
    }

    private var header: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white.opacity(0.06))
                    .frame(width: 48, height: 48)

                Image(systemName: product.imageSystemName)
                    .font(.system(size: 22))
                    .foregroundColor(.purple)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)

                Text(product.category)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))

                Text(product.price, format: .currency(code: "USD"))
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
            }

            Spacer()

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white.opacity(0.8))
            }
            .buttonStyle(.plain)
        }
    }

    private func loadCurrentValues() {
        if let currentFeatured = store.featuredProduct,
           currentFeatured.id == product.id {
            isFeatured = true
        } else {
            isFeatured = false
        }

        isHidden = store.isHidden(product)
        badgeText = store.badge(for: product) ?? ""
    }

    private func applyChanges() {
        if isFeatured {
            store.setFeatured(product)
        } else if store.featuredProduct?.id == product.id {
            // crude “unfeature” by clearing featured product
            store.setFeatured(nil)
        }

        store.setHidden(isHidden, for: product)
        store.setBadge(badgeText.trimmingCharacters(in: .whitespacesAndNewlines),
                       for: product)
    }
}
