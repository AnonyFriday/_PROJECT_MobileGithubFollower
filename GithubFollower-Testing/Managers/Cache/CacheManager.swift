//
//  CacheManager.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 28/12/20.
//

import UIKit

final class CacheImageManager {
    
    fileprivate static let cache = NSCache<NSString, UIImage>()
    
    static func setCacheImage<T>(data: T, key: NSString) where T : UIImage {
        cache.setObject(data, forKey: key)
    }
    
    static func getCacheImage<T>(key: NSString) -> T? where T : UIImage {
        guard let image = cache.object(forKey: key) else {
            return nil
        }
        return image as? T
    }
    
    
}

