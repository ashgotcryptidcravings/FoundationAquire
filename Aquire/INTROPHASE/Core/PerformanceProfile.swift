//
//  DeviceTier.swift
//  Aquire
//
//  Created by Zero on 12/11/25.
//


import SwiftUI
import Combine

/// Rough performance tiers used to decide how "fancy"
/// the UI should be on a given device.
enum DeviceTier {
    case low
    case medium
    case high
}

/// A simple struct describing how intense the visuals should be.
struct VisualTuning {
    let blurStrength: CGFloat      // 0 = off
    let shadowRadius: CGFloat      // in points
    let animationLevel: Int        // 0 = off, 1 = subtle, 2 = full
}

/// User-facing performance preference.
enum AquirePerformancePreference: String, CaseIterable, Identifiable {
    case battery
    case balanced
    case cinematic

    var id: String { rawValue }

    var label: String {
        switch self {
        case .battery:   return "Battery Saver"
        case .balanced:  return "Balanced"
        case .cinematic: return "Cinematic"
        }
    }

    var description: String {
        switch self {
        case .battery:
            return "Fewer effects, best for older devices or long sessions."
        case .balanced:
            return "A mix of smooth performance and visual detail."
        case .cinematic:
            return "Maximum glass, motion, and depth on supported hardware."
        }
    }
}

/// Central performance + tuning manager.
/// Combines device tier, user preference, and (later) runtime signals.
final class PerformanceProfile: ObservableObject {

    // MARK: - Published

    @Published var preference: AquirePerformancePreference {
        didSet {
            defaults.set(preference.rawValue, forKey: Keys.preference)
            objectWillChange.send()
        }
    }

    @Published var autoTuneEnabled: Bool {
        didSet {
            defaults.set(autoTuneEnabled, forKey: Keys.autoTuneEnabled)
            objectWillChange.send()
        }
    }

    /// Static classification of the current device.
    /// This is intentionally rough – it's a starting heuristic.
    let deviceTier: DeviceTier

    // MARK: - Private

    private let defaults: UserDefaults

    private struct Keys {
        static let preference      = "Aquire_perfPreference"
        static let autoTuneEnabled = "Aquire_perfAutoTuneEnabled"
    }

    // MARK: - Init

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        // Load stored preference (default = balanced)
        if let raw = defaults.string(forKey: Keys.preference),
           let pref = AquirePerformancePreference(rawValue: raw) {
            self.preference = pref
        } else {
            self.preference = .balanced
        }

        // Load stored auto-tune flag (default = true)
        if defaults.object(forKey: Keys.autoTuneEnabled) == nil {
            self.autoTuneEnabled = true
        } else {
            self.autoTuneEnabled = defaults.bool(forKey: Keys.autoTuneEnabled)
        }

        self.deviceTier = PerformanceProfile.classifyCurrentDevice()
    }

    // MARK: - Tuning

    /// Current visual tuning derived from device tier + preference.
    var currentTuning: VisualTuning {
        // Base per-tier tuning
        let base: VisualTuning
        switch deviceTier {
        case .low:
            base = VisualTuning(
                blurStrength: 0,
                shadowRadius: 6,
                animationLevel: 0
            )
        case .medium:
            base = VisualTuning(
                blurStrength: 8,
                shadowRadius: 14,
                animationLevel: 1
            )
        case .high:
            base = VisualTuning(
                blurStrength: 20,
                shadowRadius: 24,
                animationLevel: 2
            )
        }

        // Adjust based on user preference
        switch preference {
        case .battery:
            return VisualTuning(
                blurStrength: max(0, base.blurStrength * 0.4),
                shadowRadius: max(0, base.shadowRadius * 0.5),
                animationLevel: min(base.animationLevel, 1)
            )
        case .balanced:
            return base
        case .cinematic:
            return VisualTuning(
                blurStrength: base.blurStrength * 1.3,
                shadowRadius: base.shadowRadius * 1.2,
                animationLevel: max(base.animationLevel, 2)
            )
        }
    }

    // MARK: - Device classification

    private static func classifyCurrentDevice() -> DeviceTier {
        #if os(iOS)
        let identifier = hardwareIdentifier()

        // Very rough sets – expand over time as needed.
        let lowDevices: Set<String> = [
            "iPhone10,1", "iPhone10,4", // 8
            "iPhone10,2", "iPhone10,5", // 8 Plus
            "iPhone10,3", "iPhone10,6", // X
            "iPhone11,8"                // XR
        ]

        let highDevices: Set<String> = [
            "iPhone15,2", "iPhone15,3", // 14 Pro / Pro Max
            "iPhone16,1", "iPhone16,2"  // 15 Pro / Pro Max (example)
        ]

        if lowDevices.contains(identifier) {
            return .low
        } else if highDevices.contains(identifier) {
            return .high
        } else {
            return .medium
        }
        #elseif os(macOS)
        // Assume medium by default; Apple silicon can be treated as high later.
        return .medium
        #else
        return .medium
        #endif
    }

    private static func hardwareIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        return withUnsafePointer(to: &systemInfo.machine) { ptr in
            let int8Ptr = UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self)
            return String(cString: int8Ptr)
        }
    }
}