import Foundation

/// Lightweight AI service scaffold.
/// - Purpose: Provide a single place to plug in Apple Intelligence / FoundationModels in the future.
/// - Current behavior: Synchronous heuristic summary (safe, no external dependencies). Replace implementation with FoundationModels calls when on-device models are available.
final class AIService {
    static let shared = AIService()
    private init() {}

    /// Generate a short product summary. This default implementation is local and deterministic.
    /// Replace the body of this method with an on-device FoundationModels call when you opt into the new SDK.
    func generateShortSummary(for name: String, description: String) async -> String {
        // Fast heuristic: keep first sentence, append short features bullet.
        let firstSentence = description.split(maxSplits: 1, omittingEmptySubsequences: true, whereSeparator: { $0 == "." || $0 == "!" || $0 == "?" }).first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? description

        let features = [
            "Compact, modern design",
            "Optimized for Foundation ecosystems",
            "Supports AR & 3D preview"
        ]

        let summary = "\(firstSentence).\n\nKey features:\n- \(features.joined(separator: "\n- "))"
        return summary
    }
}