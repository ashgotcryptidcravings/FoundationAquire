import SwiftUI

struct AquireStatTile: View {
    let label: String
    let value: String
    let icon: String

    var body: some View {
        AquireSurface(cornerRadius: 22, padding: 14) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.85))

                VStack(alignment: .leading, spacing: 4) {
                    Text(label)
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.65))

                    Text(value)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }

                Spacer(minLength: 0)
            }
        }
    }
}