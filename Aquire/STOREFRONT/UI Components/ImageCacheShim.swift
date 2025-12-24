import UIKit

/// Lightweight ImageCache shim placed in UI Components so UI files compile even if the
/// Utilities copy of ImageCache isn't added to the target. If you prefer the Utilities
/// implementation, remove this file and ensure `Aquire/STOREFRONT/Utilities/ImageCache.swift`
/// is added to the app target in Xcode.
final class ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {
        cache.countLimit = 128
        cache.totalCostLimit = 50 * 1024 * 1024
    }

    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    func set(_ image: UIImage, forKey key: String) {
        let cost = image.pngData()?.count ?? 0
        cache.setObject(image, forKey: key as NSString, cost: cost)
    }

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
