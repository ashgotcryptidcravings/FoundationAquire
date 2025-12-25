import Foundation
import SceneKit

/// Simple in-memory cache for SCNScene objects loaded from bundled USDZ/scene files.
/// Uses NSCache to allow automatic eviction under memory pressure.
final class SceneCache {
    static let shared = SceneCache()

    private let cache = NSCache<NSString, SCNScene>()
    private init() {
        // Sensible defaults; tune if you have many heavy scenes.
        cache.countLimit = 16
        cache.totalCostLimit = 200 * 1024 * 1024 // ~200MB
    }

    /// Load a scene for a bundle resource name (without extension), caching the result.
    /// This runs on a background thread and returns the loaded SCNScene or nil if not found.
    func loadScene(named name: String) async -> SCNScene? {
        if let cached = cache.object(forKey: name as NSString) {
            return cached
        }

        return await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                // Try possible extensions in order; USDZ is common but allow .scn/.dae if present.
                let exts = ["usdz", "scn", "dae"]
                var loaded: SCNScene? = nil

                for ext in exts {
                    if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                        // Try SCNScene initializer that accepts URL (may throw), wrap in try?
                        if let scene = try? SCNScene(url: url, options: nil) {
                            loaded = scene
                            break
                        }
                        // Fallback to named initializer (uses bundle lookup)
                        if let scene = SCNScene(named: "\(name).\(ext)") {
                            loaded = scene
                            break
                        }
                    }
                }

                if let scene = loaded {
                    // Cache with a rough cost estimate: sum geometry vertex buffers sizes isn't trivial here,
                    // so we use an approximate fixed cost per scene; NSCache will evict on pressure.
                    self.cache.setObject(scene, forKey: name as NSString, cost: 1)
                }

                continuation.resume(returning: loaded)
            }
        }
    }

    /// Remove a cached scene (optional).
    func removeScene(named name: String) {
        cache.removeObject(forKey: name as NSString)
    }
}
