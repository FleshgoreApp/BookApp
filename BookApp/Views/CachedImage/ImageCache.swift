//
//  ImageCache.swift
//  AsyncImageStarter
//

import Foundation

final class ImageCache {
    // MARK: - Properties
    typealias CacheType = NSCache<NSString, NSData>
    static let shared = ImageCache()
    
    private let lock = NSLock()
    private lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024 // 52428800 Bytes > 50MB
        return cache
    }()
    
    // MARK: - Initialization
    private init() {}
    
    // MARK: - Open
    func object(forkey key: NSString) -> Data? {
        lock.lock()
        defer { lock.unlock() }
        return cache.object(forKey: key) as Data?
    }
    
    func set(object: NSData, forKey key: NSString) {
        lock.lock()
        cache.setObject(object, forKey: key)
        lock.unlock()
    }
}
