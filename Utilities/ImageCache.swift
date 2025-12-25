import UIKit

/// Simple in-memory image cache with async loader for bundled assets.
/// Uses NSCache to avoid unbounded growth and keeps a small API that's easy to use from SwiftUI .task.
final class ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {
        cache.countLimit = 128
        cache.totalCostLimit = 50 * 1024 * 1024 // ~50MB default
    }

    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    func set(_ image: UIImage, forKey key: String) {
        let cost = image.pngData()?.count ?? 0
        cache.setObject(image, forKey: key as NSString, cost: cost)
    }

    /// Asynchronously load a bundled image by name (or return cached). This is optimized for bundled
    /// assets that may be expensive to decode repeatedly.
    func loadImageAsync(named name: String) async -> UIImage? {
        if let img = image(forKey: name) { return img }

        return await withCheckedContinuation { cont in
            DispatchQueue.global(qos: .userInitiated).async {
                let img = UIImage(named: name)
                if let img { self.set(img, forKey: name) }
                cont.resume(returning: img)
            }
        }
    }
}
