import SwiftUI

// MARK: - Models

struct TOSCard: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

struct Teaser: Identifiable {
    let id = UUID()
    let displayTitle: String
    let subtitle: String
    let softHint: String
    let puzzleString: String   // hidden code for future decoding
}

// MARK: - InfoView

@available(macOS 12.0, iOS 15.0, *)
struct InfoView: View {
    @EnvironmentObject var store: StoreModel
    let userEmail: String?

    // Play TOS cards (vibes, not legal)
    private let tosCards: [TOSCard] = [
        TOSCard(
            title: "You are not the product",
            subtitle: "FoundationOS treats your data as local gravity, not ad fuel."
        ),
        TOSCard(
            title: "Opt-in, not opt-out",
            subtitle: "Nothing leaves your device unless you explicitly open the door."
        ),
        TOSCard(
            title: "Built for tinkerers",
            subtitle: "Root access is a feature, not an accident."
        )
    ]

    // In-production teaser signals
    private let teasers: [Teaser] = [
        Teaser(
            displayTitle: "Signal 01",
            subtitle: "Origin: Foundation Labs · Status: Murmuring",
            softHint: "Protocol: Θ-19 · Channel: 4:4:0",
            puzzleString: "U0lHTkFMMDFF:RF9BQ0NFU1NfUE9JTkQ=" // fake, but looks decode-able
        ),
        Teaser(
            displayTitle: "Signal 02",
            subtitle: "Origin: Sublevel • • · Status: Redacted",
            softHint: "Vector: N/E · Phase: 03",
            puzzleString: "MjQtOS0xOS0yMi0yMQ==" // looks like a number sequence
        ),
        Teaser(
            displayTitle: "Signal 03",
            subtitle: "Origin: Surface Mesh · Status: Silent",
            softHint: "Carrier: 198574 · Band: 03",
            puzzleString: "ZXJ5c3N1bH50b3J1cw==" // little Eryssulynth nod
        )
    ]

    @State private var selectedTeaserIndex: Int = 0
    @State private var atmosphereMotion: CGFloat = 0.0        // slow drift
    @State private var channelAccent: Color = Color.purple.opacity(0.75)  // animated accent

    var body: some View {
        ZStack {
            atmosphereLayer

            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    osExplainerSection
                    tosSection
                    signalsSection
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
                .frame(maxWidth: 780)
                .frame(maxWidth: .infinity)
            }
        }
        .aquireBackground()
        .onAppear {
            // Start slow background motion
            atmosphereMotion = 0.0
            withAnimation(.linear(duration: 28).repeatForever(autoreverses: true)) {
                atmosphereMotion = 1.0
            }
            // Sync accent with initial signal
            updateChannelAccent(for: selectedTeaserIndex)
        }
    }

    // MARK: - Atmosphere layer

    /// One gradient per signal, crossfaded by opacity -> super smooth transitions.
    private var atmosphereLayer: some View {
        ZStack {
            ForEach(0..<teasers.count, id: \.self) { index in
                atmosphereGradient(for: index)
                    .opacity(selectedTeaserIndex == index ? 1.0 : 0.0)
            }
        }
        .animation(.easeInOut(duration: 0.9), value: selectedTeaserIndex)
        .ignoresSafeArea()
    }

    /// Gradient + moving glow for a specific signal index.
    private func atmosphereGradient(for index: Int) -> some View {
        let (topColor, bottomColor) = atmosphereColors(for: index)

        // Motion factor (0 → 1 → 0) controlling glow center
        let motion = atmosphereMotion
        let centerX = 0.15 + 0.7 * Double(motion)          // sweeps left → right
        let centerY = 0.25 + 0.15 * Double(1 - motion)     // slight vertical drift

        return ZStack {
            LinearGradient(
                gradient: Gradient(colors: [topColor, bottomColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RadialGradient(
                gradient: Gradient(colors: [
                    topColor.opacity(0.6),
                    .clear
                ]),
                center: UnitPoint(x: centerX, y: centerY),
                startRadius: 80,
                endRadius: 520
            )
        }
        .opacity(0.38)
    }

    /// Palette per signal.
    private func atmosphereColors(for index: Int) -> (Color, Color) {
        switch index {
        case 0:
            // Labs – richer violet glow
            return (Color.purple.opacity(0.75), .black)
        case 1:
            // Sublevel – deeper, reddish tension
            return (Color(red: 0.9, green: 0.2, blue: 0.35).opacity(0.85), .black)
        case 2:
            // Surface Mesh – cooler blue field
            return (Color.blue.opacity(0.8), .black)
        default:
            return (Color.purple.opacity(0.6), .black)
        }
    }

    /// Update the accent color for cards and detail block.
    private func updateChannelAccent(for index: Int) {
        let (top, _) = atmosphereColors(for: index)
        channelAccent = top
    }

    // MARK: - Sections

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("FoundationOS")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)

            Text("The spine of your Foundation stack.")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.7))

            HStack(spacing: 8) {
                if let email = userEmail, !email.isEmpty {
                    Text(email)
                        .font(.system(size: 11))
                        .foregroundColor(.white.opacity(0.6))
                }
                Text("\(store.acquiredProducts.count) items owned · \(store.wishlistProducts.count) in wishlist")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.purple.opacity(0.9))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var osExplainerSection: some View {
        let accent = channelAccent

        return VStack(alignment: .leading, spacing: 12) {
            Text("What is FoundationOS?")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)

            Text("FoundationOS is the control layer that sits between your devices, wearables, docks, and whatever you invent next. It doesn’t ask you to trust the cloud — it asks you to trust your own stack.")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.8))

            VStack(spacing: 8) {
                infoRow(
                    icon: "square.stack.3d.up",
                    title: "Stack-first design",
                    detail: "Devices, wearables, docks, and services all speak the same internal language.",
                    accentColor: accent
                )
                infoRow(
                    icon: "lock.shield",
                    title: "Local by default",
                    detail: "Telemetry stays on-device unless you deliberately route it out.",
                    accentColor: accent
                )
                infoRow(
                    icon: "waveform.path.ecg",
                    title: "Built for signals",
                    detail: "Designed around live metrics, emotional state, and nervous-system inputs.",
                    accentColor: accent
                )
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(red: 0.08, green: 0.08, blue: 0.1))
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func infoRow(
        icon: String,
        title: String,
        detail: String,
        accentColor: Color
    ) -> some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.9),
                                accentColor.opacity(0.32)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                Image(systemName: icon)
                    .foregroundColor(accentColor.opacity(0.95))
                    .font(.system(size: 14, weight: .semibold))
            }
            .frame(width: 30, height: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                Text(detail)
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()
        }
        .animation(.easeInOut(duration: 0.9), value: accentColor)
    }

    private var tosSection: some View {
        let accent = channelAccent

        return VStack(alignment: .leading, spacing: 10) {
            Text("Play TOS")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)

            Text("Not legalese. Just the rules this stack plays by.")
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.7))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(tosCards) { card in
                        TOSCardView(card: card, accentColor: accent)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var signalsSection: some View {
        // Clamp just in case, but teasers is non-empty.
        let clampedIndex = min(max(selectedTeaserIndex, 0), teasers.count - 1)
        let selected = teasers[clampedIndex]
        let accentColor = channelAccent

        return VStack(alignment: .leading, spacing: 10) {
            Text("Signals")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)

            Text("In-production prototypes, encoded. Most people will just see vibes.")
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.7))

            // Teaser cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(Array(teasers.enumerated()), id: \.element.id) { index, teaser in
                        TeaserCardView(
                            teaser: teaser,
                            isSelected: index == selectedTeaserIndex,
                            accentColor: accentColor
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.9)) {
                                selectedTeaserIndex = index
                                updateChannelAccent(for: index)
                            }
                        }
                    }
                }
                .padding(.vertical, 6)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Active signal: \(selected.displayTitle)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(accentColor.opacity(0.95))

                Text(selected.softHint)
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.8))

                // Looks like noise, is actually the puzzle string.
                Text(selected.puzzleString)
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundColor(accentColor.opacity(0.6))
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white.opacity(0.03))
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Subviews

@available(macOS 12.0, iOS 15.0, *)
struct TOSCardView: View {
    let card: TOSCard
    let accentColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(card.title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)

            Text(card.subtitle)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.75))
        }
        .padding(14)
        .frame(width: 220, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            accentColor.opacity(0.45),
                            Color.black.opacity(0.95)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(accentColor.opacity(0.6), lineWidth: 1)
        )
        .animation(.easeInOut(duration: 0.9), value: accentColor)
    }
}

@available(macOS 12.0, iOS 15.0, *)
struct TeaserCardView: View {
    let teaser: Teaser
    let isSelected: Bool
    let accentColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(teaser.displayTitle)
                    .font(.system(size: 13, weight: .semibold))
                Spacer()
                Circle()
                    .fill(isSelected ? accentColor : Color.white.opacity(0.25))
                    .frame(width: 8, height: 8)
            }
            .foregroundColor(.white)

            Text(teaser.subtitle)
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.7))

            Spacer()

            Text("Tap to tune signal")
                .font(.system(size: 10))
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(14)
        .frame(width: 220, height: 120, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black,
                            accentColor.opacity(0.55)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(
                    isSelected ? accentColor.opacity(0.95)
                               : Color.white.opacity(0.15),
                    lineWidth: 1
                )
        )
        .shadow(
            color: accentColor.opacity(isSelected ? 0.45 : 0.2),
            radius: isSelected ? 18 : 8,
            x: 0,
            y: isSelected ? 10 : 4
        )
        .animation(.easeInOut(duration: 0.35), value: isSelected)
    }
}
