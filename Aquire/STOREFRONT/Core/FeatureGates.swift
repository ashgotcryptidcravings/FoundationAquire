import SwiftUI

/// Centralized switches that decide what visual features are allowed.
/// This is how we do “device editions” without multiple apps.
final class FeatureGates: ObservableObject {

    struct Gates {
        var allowHeavyBlur: Bool
        var allowHighlightOverlay: Bool
        var allowShadows: Bool
        var allowAnimations: Bool
        var allow3DPreview: Bool
        var allowLargeListsEffects: Bool
    }

    @Published private(set) var gates: Gates = Gates(
        allowHeavyBlur: false,
        allowHighlightOverlay: false,
        allowShadows: true,
        allowAnimations: true,
        allow3DPreview: true,
        allowLargeListsEffects: false
    )

    func recompute(
        performance: PerformanceProfile,
        profile: AppProfile
    ) {
        let tuning = performance.currentTuning

        // Hard throttles (system)
        let throttled = performance.systemThrottleActive

        // “Edition” preference from onboarding
        let exp = profile.experience

        // Base rules from tuning (which already uses device/system hints)
        var allowBlur = tuning.blurStrength > 0
        var allowHighlight = tuning.allowHighlightOverlay
        var allowShadows = tuning.shadowRadius > 0
        var allowAnimations = tuning.animationLevel > 0

        // Start with “safe defaults”
        var allow3D = true
        var allowLargeEffects = false

        // Edition knobs
        switch exp {
        case .performance:
            allowBlur = false
            allowHighlight = false
            allowShadows = true
            allowAnimations = false
            allow3D = false
            allowLargeEffects = false

        case .balanced:
            allowBlur = allowBlur
            allowHighlight = allowHighlight
            allowShadows = allowShadows
            allowAnimations = allowAnimations
            allow3D = true
            allowLargeEffects = false

        case .cinematic:
            allowBlur = true
            allowHighlight = true
            allowShadows = true
            allowAnimations = true
            allow3D = true
            allowLargeEffects = true
        }

        // System throttles override everything
        if throttled {
            allowBlur = false
            allowHighlight = false
            allowAnimations = false
            allow3D = false
            allowLargeEffects = false
        }

        gates = Gates(
            allowHeavyBlur: allowBlur,
            allowHighlightOverlay: allowHighlight,
            allowShadows: allowShadows,
            allowAnimations: allowAnimations,
            allow3DPreview: allow3D,
            allowLargeListsEffects: allowLargeEffects
        )
    }
}