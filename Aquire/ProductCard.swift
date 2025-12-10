import SwiftUI

/// Universal hero-style card for a single product.
/// Purely visual: parent decides ownership / model state.
struct ProductCard: View {
    let product: Product
    let hasModel: Bool
    let isOwned: Bool

    @State private var hasAppeared: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .center, spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.black.opacity(0.6))

                    Image(systemName: product.imageSystemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 52, height: 52)
                        .foregroundColor(.purple)
                }
                .frame(width: 90, height: 90)

                VStack(alignment: .leading, spacing: 6) {
                    Text(product.category.uppercased())
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.white.opacity(0.7))

                    Text(product.name)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(1)

                    Text(product.price, format: .currency(code: "USD"))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }

                Spacer()
            }

            Text(product.description)
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.85))
                .lineLimit(3)

            HStack(spacing: 10) {
                if hasModel {
                    Text("3D MODEL")
                        .font(.system(size: 11, weight: .bold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.purple.opacity(0.95))
                        )
                        .foregroundColor(.white)
                }

                if isOwned {
                    HStack(spacing: 5) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.green)

                        Text("In your collection")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }

                Spacer()
            }
            .padding(.top, 4)
        }
        .padding(18)
        .liquidGlass(cornerRadius: 26)
        .opacity(hasAppeared ? 1 : 0)
        .offset(y: hasAppeared ? 0 : 18)
        .animation(
            .spring(response: 0.6, dampingFraction: 0.8),
            value: hasAppeared
        )
        .onAppear { hasAppeared = true }
    }
}
