//
//  CollectionViewExtentions.swift
//  CrossAdsSDK
//
//  Created by Mabed on 15/09/2022.
//

import Foundation
import UIKit

public extension UICollectionView {
    func registerCrossAdsCells() {
        register(UINib(nibName: BannerCollectionViewCell.identifier, bundle: Bundle.getBundleForClass(cl: BannerCollectionViewCell.self)), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
    }
    
    func dequeueBannerCell(crossAd: CrossAdModel, placeholderImage: UIImage?, indexPath: IndexPath) -> BannerCollectionViewCell {
        
        var cell: BannerCollectionViewCell?
        cell = dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell
        if cell == nil {
            registerCrossAdsCells()
            cell = dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell
        }
        cell?.presentation = Presentation(adModel: crossAd, placeholderImage: placeholderImage, adHeight: crossAd.height)
        return cell ?? BannerCollectionViewCell()
    }
}
