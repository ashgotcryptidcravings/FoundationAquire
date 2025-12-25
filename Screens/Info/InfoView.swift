import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                AquireHeroCard(
                    title: "Info",
                    subtitle: "Aquire is the Foundation storefront and command surface.",
                    systemImage: "info.circle"
                )

                AquireSurface(cornerRadius: 28, padding: 18) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("About Aquire")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Text("Aquire is a curated catalog, wishlist, acquisition log, and order timeline for Foundation hardware.")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.78))
                    }
                }
            }
            .padding(16)
        }
        .background(AquireBackdrop().ignoresSafeArea())
    }
}
