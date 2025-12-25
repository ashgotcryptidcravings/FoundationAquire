import Foundation
import RealityKit

/// Actor-based cache for loaded ModelEntity instances.
/// Stores cloned copies on request to keep callers isolated from shared instances.
actor ModelCache {
    static let shared = ModelCache()

    private var cache: [String: ModelCacheEntry] = [:]
    private var order: [String] = [] // LRU order: most recent at end
    private let maxEntries: Int

    init(maxEntries: Int = 8) {
        self.maxEntries = maxEntries
    }

    func getClone(for key: String) -> ModelEntity? {
        guard let entry = cache[key] else { return nil }
        // update LRU
        if let idx = order.firstIndex(of: key) {
            order.remove(at: idx)
            order.append(key)
        }
        return entry.entity.clone(recursive: true)
    }

    func set(_ entity: ModelEntity, for key: String) {
        let entry = ModelCacheEntry(entity: entity)
        cache[key] = entry
        // update LRU
        if let idx = order.firstIndex(of: key) {
            order.remove(at: idx)
        }
        order.append(key)
        // evict if needed
        evictIfNeeded()
    }

    private func evictIfNeeded() {
        while order.count > maxEntries {
            let evictKey = order.removeFirst()
            cache.removeValue(forKey: evictKey)
        }
    }

    func clear() {
        cache.removeAll()
        order.removeAll()
    }
}

private final class ModelCacheEntry {
    let entity: ModelEntity
    init(entity: ModelEntity) {
        self.entity = entity
    }
}
