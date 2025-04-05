//
//  UserCacheManager.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-04.
//

import Foundation

class UserCacheManager {
    private let cache = NSCache<NSString, CacheEntry>()
    private let cacheExpirationTime: TimeInterval = 300 // 5 mins
    
    static let shared = UserCacheManager()
    
    private init() {}
    
    func cacheUser(_ user: User) {
        let entry = CacheEntry(user: user, timestamp: Date())
        cache.setObject(entry, forKey: user.login as NSString)
    }
    
    func getUser(for username: String) -> User? {
        guard let entry = cache.object(forKey: username as NSString) else {
            return nil
        }
        
        if Date().timeIntervalSince(entry.timestamp) > cacheExpirationTime {
            cache.removeObject(forKey: username as NSString)
            return nil
        }
        
        return entry.user
    }
    
    func invalidateCache(for username: String) {
        cache.removeObject(forKey: username as NSString)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}

class CacheEntry: NSObject {
    let user: User
    let timestamp: Date
    
    init(user: User, timestamp: Date) {
        self.user = user
        self.timestamp = timestamp
    }
}
