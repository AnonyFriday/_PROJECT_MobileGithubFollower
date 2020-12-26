
import UIKit

enum CacheManager {
    static private let cachedImage = NSCache<NSString, UIImage>()
    
    static func insert(_ image: UIImage, with key: NSString) {
        cachedImage.setObject(image, forKey: key)
    }
    
    static func getImageFromKey(_ key: NSString) -> UIImage? {
        guard let image = cachedImage.object(forKey: key) else {
            return nil
        }
        return image
    }
}

