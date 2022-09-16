//
//  CrossAdModel.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 27/06/2022.
//

import Foundation

public protocol Advertizable {
    var isCrossAd: Bool? { get set }
}

public enum CrossAdType: String, Codable {
    case bannerImage
    case detaildBanner
    case medium
    case interstitial
    case bannerImageCollectionView
}

public struct CrossAdModel: Codable, Advertizable {
    public var isCrossAd: Bool? = true
    
    public var id: String
    public var image: String?
    public var mainImage: String?
    public var title: String?
    public var actionButtonTitle: String?
    public var subTitle: String?
    public var type: CrossAdType?
    public var url: String?
    public var backupUrl: String?
    public var view_freq: Int?
    public var click_freq: Int?
    public var backgroundColor: String?
    public var allowDismissAfter: Double?
    public var height: CGFloat?
}
