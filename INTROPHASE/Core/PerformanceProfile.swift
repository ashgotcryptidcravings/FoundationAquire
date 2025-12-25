//
//  PerformanceProfile.swift
//  Aquire
//

import Foundation
import SwiftUI

@MainActor
final class PerformanceProfile: ObservableObject {

    enum Tier: String, CaseIterable {
        case cinematic
        case balanced
        case performance
    }

    struct Tuning: Equatable {
        var animationLevel: Int = 1
        var blurStrength: Double = 1.0

        var allowHeavyBlur: Bool = true
        var allowShadows: Bool = true
        var shadowRadius: CGFloat = 12
        var allowHighlightOverlay: Bool = true
    }

    @Published var currentTuning: Tuning = .init()
    @Published var thermalState: ProcessInfo.ThermalState = .nominal
    @Published var isLowPowerMode: Bool = false
    @Published var tier: Tier = .balanced

    /// “Throttle” = system is asking us to chill (thermal or low power).
    var systemThrottleActive: Bool {
        isLowPowerMode || thermalState == .serious || thermalState == .critical
    }

    init() {
        startMonitoring()
    }

    func startMonitoring() {
        let process = ProcessInfo.processInfo

        thermalState = process.thermalState
        isLowPowerMode = process.isLowPowerModeEnabled

        NotificationCenter.default.addObserver(
            forName: ProcessInfo.thermalStateDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor in
                self.thermalState = process.thermalState
                self.recomputeTier()
            }
        }

        NotificationCenter.default.addObserver(
            forName: .NSProcessInfoPowerStateDidChange,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor in
                self.isLowPowerMode = process.isLowPowerModeEnabled
                self.recomputeTier()
            }
        }

        recomputeTier()
    }

    private func recomputeTier() {
        if isLowPowerMode {
            tier = .performance
        } else {
            switch thermalState {
            case .serious, .critical:
                tier = .performance
            case .fair:
                tier = .balanced
            default:
                tier = .cinematic
            }
        }

        applyTuning(for: tier)
    }

    private func applyTuning(for tier: Tier) {
        switch tier {
        case .performance:
            currentTuning = Tuning(
                animationLevel: 0,
                blurStrength: 0.0,
                allowHeavyBlur: false,
                allowShadows: false,
                shadowRadius: 0,
                allowHighlightOverlay: false
            )

        case .balanced:
            currentTuning = Tuning(
                animationLevel: 1,
                blurStrength: 0.55,
                allowHeavyBlur: true,
                allowShadows: true,
                shadowRadius: 10,
                allowHighlightOverlay: true
            )

        case .cinematic:
            currentTuning = Tuning(
                animationLevel: 2,
                blurStrength: 1.0,
                allowHeavyBlur: true,
                allowShadows: true,
                shadowRadius: 12,
                allowHighlightOverlay: true
            )
        }
    }
}

extension ProcessInfo.ThermalState {
    var friendlyName: String {
        switch self {
        case .nominal: return "Nominal"
        case .fair: return "Fair"
        case .serious: return "Serious"
        case .critical: return "Critical"
        @unknown default: return "Unknown"
        }
    }
}

// MARK: - Derived Visual Weights

extension PerformanceProfile.Tuning {
    var shadowStrength: CGFloat {
        let b = blurStrength
        if b < 0.15 { return 0.10 }
        if b < 0.35 { return 0.25 }
        if b < 0.60 { return 0.45 }
        return 0.65
    }
}
