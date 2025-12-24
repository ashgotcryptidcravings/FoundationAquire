import SwiftUI

struct ProductDetailView: View {
    let product: Product
    var showsCloseButton: Bool = false
    
    @EnvironmentObject private var store: StoreModel
    @EnvironmentObject private var telemetry: Telemetry
    @Environment(\.dismiss) private var dismiss
    
    @State private var isUpdatingFirmware = false
    
    private var productKey: String? { ProductCatalog.key(for: product) }
    
    private var acquiredQty: Int {
        guard let key = productKey else { return 0 }
        return store.acquired[key, default: 0]
    }
    
    private var isOwned: Bool { acquiredQty > 0 }
    
    private var isWishlisted: Bool {
        guard let key = productKey else { return false }
        return store.wishlist.contains(key)
    }
    private func toggleWishlist() {
        guard let key = productKey else { return }
        if isWishlisted {
            store.removeFromWishlist(key)
            telemetry.log("wishlist_remove", source: key)
        } else {
            store.addToWishlist(key)
            telemetry.log("wishlist_add", source: key)
        }
    }

    private func buy() {
        guard let key = productKey else { return }
        telemetry.log("purchase_tap", source: key)
        store.placeOrder(for: key)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if showsCloseButton {
                        HStack {
                            Spacer()
                            Button { dismiss() } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundColor(.white.opacity(0.85))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    AquireSurface {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Firmware")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(.white.opacity(0.9))
                                Spacer()
                                Text("v1.0 (placeholder)")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundColor(.white.opacity(0.65))
                            }
                            
                            Button {
                                isUpdatingFirmware = true
                                Task { @MainActor in
                                    try? await Task.sleep(nanoseconds: 650_000_000)
                                    isUpdatingFirmware = false
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                    Text(isUpdatingFirmware ? "Updating…" : "Check for Updates")
                                }
                                .font(.system(size: 13, weight: .bold, design: .rounded))
                                .foregroundColor(.white.opacity(0.9))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                                        .fill(Color.white.opacity(0.10))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                                .stroke(Color.white.opacity(0.18), lineWidth: 0.9)
                                        )
                                )
                            }
                            .buttonStyle(.plain)
                            .disabled(!isOwned)
                            .opacity(isOwned ? 1 : 0.55)
                            
                            Text(isOwned ? "Firmware tools unlock once you own the device."
                                 : "Purchase to unlock device management.")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.65))
                        }
                    }
                    
                    AquireSurface {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("About")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text(product.description)
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .foregroundColor(.white.opacity(0.72))
                        }
                    }
                    
                    Spacer(minLength: 8)
                }
                .padding(18)
            }
        }
    }
}
