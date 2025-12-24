import SwiftUI
import Combine

enum DeviceTier {
    case low
    case medium
    case high
}

struct VisualTuning {
    let blurStrength: CGFloat      // 0 = off
    let shadowRadius: CGFloat      // pts
    let animationLevel: Int        // 0 = off, 1 = subtle, 2 = full
    let allowBackgroundBlur: Bool  // expensive
    let allowHighlightOverlay: Bool
}

enum AquirePerformancePreference: String, CaseIterable, Identifiable {
    case battery
    case balanced
    case cinematic

    var id: String { rawValue }

    var label: String {
        switch self {
        case .battery: return "Battery Saver"
        case .balanced: return "Balanced"
        case .cinematic: return "Cinematic"
        }
    }

    var description: String {
        switch self {
        case .battery:
            return "Lowest GPU cost. Minimal blur, minimal animation."
        case .balanced:
            return "Smooth default. Glass where it matters."
        case .cinematic:
            return "Highest visual detail. Not recommended when hot or Low Power."
        }
    }
}

/// PerformanceProfile v2:
/// - Uses user preference (battery/balanced/cinematic)
/// - Classifies device tier
/// - Reacts to system signals:
///   - Low Power Mode
///   - Reduce Motion / Reduce Transparency
///   - Thermal state
final class PerformanceProfile: ObservableObject {

    // MARK: - Stored user preference

    @Published var preference: AquirePerformancePreference {
        didSet {
            defaults.set(preference.rawValue, forKey: Keys.preference)
            recalc()
        }
    }

    @Published var autoTuneEnabled: Bool {
        didSet {
            defaults.set(autoTuneEnabled, forKey: Keys.autoTuneEnabled)
            recalc()
        }
    }

    // MARK: - Live system signals

    @Published private(set) var lowPowerModeEnabled: Bool = false
    @Published private(set) var reduceMotionEnabled: Bool = false
    @Published private(set) var reduceTransparencyEnabled: Bool = false
    @Published private(set) var thermalState: ProcessInfo.ThermalState = .nominal

    // MARK: - Derived

    let deviceTier: DeviceTier

    /// The final resolved tuning that UI should obey.
    @Published private(set) var currentTuning: VisualTuning = VisualTuning(
        blurStrength: 0,
        shadowRadius: 8,
        animationLevel: 0,
        allowBackgroundBlur: false,
        allowHighlightOverlay: false
    )

    // MARK: - Private

    private let defaults: UserDefaults
    private var cancellables: Set<AnyCancellable> = []

    private struct Keys {
        static let preference      = "Aquire_perfPreference"
        static let autoTuneEnabled = "Aquire_perfAutoTuneEnabled"
    }

    // MARK: - Init

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        if let raw = defaults.string(forKey: Keys.preference),
           let pref = AquirePerformancePreference(rawValue: raw) {
            self.preference = pref
        } else {
            self.preference = .balanced
        }

        if defaults.object(forKey: Keys.autoTuneEnabled) == nil {
            self.autoTuneEnabled = true
        } else {
            self.autoTuneEnabled = defaults.bool(forKey: Keys.autoTuneEnabled)
        }

        self.deviceTier = Self.classifyCurrentDevice()

        // Prime system signals
        readSystemSignals()
        startObservingSystemSignals()

        // Compute initial tuning
        recalc()
    }

    // MARK: - Public helpers (nice for overlays / settings)

    var systemThrottleActive: Bool {
        let thermalIsBad: Bool = {
            switch thermalState {
            case .serious, .critical:
                return true
            case .nominal, .fair:
                return false
            @unknown default:
                return true
            }
        }()

        return lowPowerModeEnabled
            || reduceMotionEnabled
            || reduceTransparencyEnabled
            || thermalIsBad
    }
    // MARK: - Core logic

    private func recalc() {
        // Base tier defaults
        var blur: CGFloat
        var shadow: CGFloat
        var anim: Int
        var allowBGBlur: Bool
        var allowHighlight: Bool

        switch deviceTier {
        case .low:
            blur = 0
            shadow = 6
            anim = 0
            allowBGBlur = false
            allowHighlight = false
        case .medium:
            blur = 6
            shadow = 12
            anim = 1
            allowBGBlur = true
            allowHighlight = true
        case .high:
            blur = 12
            shadow = 18
            anim = 2
            allowBGBlur = true
            allowHighlight = true
        }

        // Apply user preference
        switch preference {
        case .battery:
            blur *= 0.0
            shadow *= 0.6
            anim = 0
            allowBGBlur = false
            allowHighlight = false

        case .balanced:
            // keep base

            break

        case .cinematic:
            blur *= 1.25
            shadow *= 1.15
            anim = max(anim, 2)
            allowBGBlur = true
            allowHighlight = true
        }

        // Auto-tune: hard clamp when system is asking for mercy
        if autoTuneEnabled, systemThrottleActive {
            // Low Power / Reduce Motion / thermal serious+ means: STOP BLUR.
            blur = 0
            shadow = min(shadow, 10)
            anim = 0
            allowBGBlur = false
            allowHighlight = false
        }

        // Always clamp to sane values
        blur = max(0, min(blur, 24))
        shadow = max(0, min(shadow, 24))
        anim = max(0, min(anim, 2))

        let next = VisualTuning(
            blurStrength: blur,
            shadowRadius: shadow,
            animationLevel: anim,
            allowBackgroundBlur: allowBGBlur,
            allowHighlightOverlay: allowHighlight
        )

        if currentTuning.blurStrength != next.blurStrength ||
            currentTuning.shadowRadius != next.shadowRadius ||
            currentTuning.animationLevel != next.animationLevel ||
            currentTuning.allowBackgroundBlur != next.allowBackgroundBlur ||
            currentTuning.allowHighlightOverlay != next.allowHighlightOverlay {

            currentTuning = next
        }
    }

    // MARK: - System signals

    private func readSystemSignals() {
        #if os(iOS)
        lowPowerModeEnabled = ProcessInfo.processInfo.isLowPowerModeEnabled
        #endif

        reduceMotionEnabled = UIAccessibility.isReduceMotionEnabled
        reduceTransparencyEnabled = UIAccessibility.isReduceTransparencyEnabled
        thermalState = ProcessInfo.processInfo.thermalState
    }

    private func startObservingSystemSignals() {
        // Reduce Motion / Transparency
        NotificationCenter.default.publisher(for: UIAccessibility.reduceMotionStatusDidChangeNotification)
            .sink { [weak self] _ in
                guard let self else { return }
                self.reduceMotionEnabled = UIAccessibility.isReduceMotionEnabled
                self.recalc()
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIAccessibility.reduceTransparencyStatusDidChangeNotification)
            .sink { [weak self] _ in
                guard let self else { return }
                self.reduceTransparencyEnabled = UIAccessibility.isReduceTransparencyEnabled
                self.recalc()
            }
            .store(in: &cancellables)

        // Thermal
        NotificationCenter.default.publisher(for: ProcessInfo.thermalStateDidChangeNotification)
            .sink { [weak self] _ in
                guard let self else { return }
                self.thermalState = ProcessInfo.processInfo.thermalState
                self.recalc()
            }
            .store(in: &cancellables)

        #if os(iOS)
        // Low Power
        NotificationCenter.default.publisher(for: Notification.Name.NSProcessInfoPowerStateDidChange)
            .sink { [weak self] _ in
                guard let self else { return }
                self.lowPowerModeEnabled = ProcessInfo.processInfo.isLowPowerModeEnabled
                self.recalc()
            }
            .store(in: &cancellables)
        #endif
    }

    // MARK: - Device classification

    private static func classifyCurrentDevice() -> DeviceTier {
        #if os(iOS)
        let identifier = hardwareIdentifier()

        let low: Set<String> = [
            "iPhone10,1","iPhone10,4", // 8
            "iPhone10,2","iPhone10,5", // 8 Plus
            "iPhone10,3","iPhone10,6", // X
            "iPhone11,8"               // XR
        ]

        let high: Set<String> = [
            "iPhone15,2","iPhone15,3",
            "iPhone16,1","iPhone16,2"
        ]

        if low.contains(identifier) { return .low }
        if high.contains(identifier) { return .high }
        return .medium

        #else
        return .medium
        #endif
    }

    private static func hardwareIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        return withUnsafePointer(to: &systemInfo.machine) { ptr in
            let cptr = UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self)
            return String(cString: cptr)
        }
    }
}
