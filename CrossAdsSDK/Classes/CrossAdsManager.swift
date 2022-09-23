//
//  CrossAds.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 27/06/2022.
//

import Foundation
import FirebaseRemoteConfig
import FirebaseCore

@objc public class CrossAds: NSObject {
    
    @objc public static let shared = CrossAds()
    lazy private var remoteManager = RemoteConfigurationManager()
    var config: CrossAdsConfigration?
    public var items: [CrossAdModel] = []
    
    public var adsBannerType: [CrossAdModel] {
        items.filter({ $0.type == .bannerImage })
    }
    public var adsDetailedBannerType: [CrossAdModel] {
        items.filter({ $0.type == .detaildBanner })
    }
    public var adsInterstitialType: [CrossAdModel] {
        items.filter({ $0.type == .interstitial })
    }
    public var adsMediumType: [CrossAdModel] {
        items.filter({ $0.type == .medium })
    }
    public var adsBannerCollectionViewType: [CrossAdModel] {
        items.filter({ $0.type == .bannerImageCollectionView })
    }

    public func dropAdItem(type: CrossAdType? = nil) {
        let index = items.firstIndex { $0.type == type }
        if let index = index {
            items.remove(at: index)
        }
    }
    public func pickAdItem(type: CrossAdType? = nil) -> CrossAdModel? {
        switch type {
        case .medium:
            let item = adsMediumType.first(where: { AdsCacheManager.shared.canViewAd(id: $0.id, freq: $0.view_freq) })
            return item
        case .none:
            let item = items.first(where: { AdsCacheManager.shared.canViewAd(id: $0.id, freq: $0.view_freq) })
            return item
        case .bannerImage:
            let item = adsBannerType.first(where: { AdsCacheManager.shared.canViewAd(id: $0.id, freq: $0.view_freq) })
            return item
        case .detaildBanner:
            let item = adsDetailedBannerType.first(where: { AdsCacheManager.shared.canViewAd(id: $0.id, freq: $0.view_freq) })
            return item
        case .interstitial:
            let item = adsInterstitialType.first(where: { AdsCacheManager.shared.canViewAd(id: $0.id, freq: $0.view_freq) })
            return item
        case .bannerImageCollectionView:
            let item = adsBannerCollectionViewType.first(where: { AdsCacheManager.shared.canViewAd(id: $0.id, freq: $0.view_freq) })
            return item
        }
    }
    
    public func start(config: CrossAdsConfigration, completion: @escaping (([CrossAdModel]?, RemoteConfig?, Error?)->())) {
        self.config = config
        remoteManager.getConfig(configName: config.configName) { ads, remoteConfig, error in
            self.items = ads ?? []
            print("AdActionsManager: items.count \(self.items.count)")
            DispatchQueue.main.async {
                completion(ads,remoteConfig,error)
            }
        }
    }
}
