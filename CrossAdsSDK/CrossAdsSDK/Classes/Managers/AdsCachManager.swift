//
//  AdsCachManager.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 17/07/2022.
//

import Foundation

class AdsCacheManager {

    static var shared = AdsCacheManager()
    let tapCache = NSCache<NSString, NSNumber>()
    let viewCache = NSCache<NSString, NSNumber>()
    
    func adTapped(id: String?) {
        var num = numberAdTapping(id: id)
        guard let id = id as? NSString else { return }
        num = NSNumber(value: num.intValue + 1)
        tapCache.setObject(num, forKey: id)
    }
    
    func numberAdTapping(id: String?) -> NSNumber {
        guard let id = id as? NSString else {
            return false
        }
        if let num = tapCache.object(forKey: id) {
            return num
        }
        return NSNumber(value: 0)
    }
    
    func adViewed(id: String?) {
        var num = numberOfAdViewing(id: id)
        guard let id = id as? NSString else {
            return
        }
        num = NSNumber(value: num.intValue + 1)
        viewCache.setObject(num, forKey: id)
    }
    
    func numberOfAdViewing(id: String?) -> NSNumber {
        guard let id = id as? NSString else {
            return false
        }
        if let num = viewCache.object(forKey: id) {
            return num
        }
        return NSNumber(value: 0)
    }
    
    func canViewAd(id: String?, freq: Int?) -> Bool {
        freq ?? 0 > self.numberOfAdViewing(id: id).intValue
    }
}
