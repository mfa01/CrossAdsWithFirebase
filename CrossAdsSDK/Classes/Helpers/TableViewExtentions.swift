//
//  TableViewExtentions.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 12/07/2022.
//

import Foundation
import UIKit

public extension UITableView {
    func registerCrossAdsCells() {
        register(UINib(nibName: "CrossAdsBannerTableViewCell", bundle: .currentBundle), forCellReuseIdentifier: CrossAdsBannerTableViewCell.identifier)
        register(UINib(nibName: "CrossAdsDetailedBannerTableViewCell", bundle: .currentBundle), forCellReuseIdentifier: CrossAdsDetailedBannerTableViewCell.identifier)
        register(UINib(nibName: "CrossAdsMediumTableViewCell", bundle: .currentBundle), forCellReuseIdentifier: CrossAdsMediumTableViewCell.identifier)
        register(UINib(nibName: "CrossAdsInterstitialTableViewCell", bundle: .currentBundle), forCellReuseIdentifier: CrossAdsInterstitialTableViewCell.identifier)
    }
    
    func dequeueCrossAdsCell(crossAd: CrossAdModel, placeholderImage: UIImage?) -> CrossAdsBaseTableViewCell {
        guard let type = crossAd.type else {
            print("CrossAdsError: Unknown Type, please use one of the  available types ( bannerImage, detaildBanner, medium, interstitial)")
            return CrossAdsBaseTableViewCell()
        }
        var cell: CrossAdsBaseTableViewCell?
        cell = dequeueCell(type: type)
        if cell == nil {
            registerCrossAdsCells()
            cell = dequeueCell(type: type)
        }
        cell?.presentation = Presentation(adModel: crossAd, placeholderImage: placeholderImage, adHeight: crossAd.height)
        return cell ?? CrossAdsBaseTableViewCell()
    }
    
    func dequeueCell(type: CrossAdType) -> CrossAdsBaseTableViewCell? {
        switch type {
        case .bannerImage:
            return dequeueReusableCell(withIdentifier: CrossAdsBannerTableViewCell.identifier) as? CrossAdsBannerTableViewCell
        case .detaildBanner:
            return dequeueReusableCell(withIdentifier: CrossAdsDetailedBannerTableViewCell.identifier) as? CrossAdsBaseTableViewCell
        case .medium:
            return dequeueReusableCell(withIdentifier: CrossAdsMediumTableViewCell.identifier) as? CrossAdsBaseTableViewCell
        case .interstitial:
            return dequeueReusableCell(withIdentifier: CrossAdsInterstitialTableViewCell.identifier) as? CrossAdsBaseTableViewCell
        case .bannerImageCollectionView:
            return nil
        }
    }
}

extension Bundle {
    static var currentBundle: Bundle? {
        let frameworkBundleID  = "com.Lynx.CrossAds.CrossAdsSDK";
        return Bundle(identifier: frameworkBundleID)
    }
}
