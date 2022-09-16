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
        let bundle = Bundle(for: BannerCollectionViewCell.self)
        register(UINib(nibName: BannerCollectionViewCell.identifier, bundle: bundle), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
    }
    
    func dequeueBannerCell(crossAd: CrossAdModel, placeholderImage: UIImage?, height: CGFloat?, indexPath: IndexPath) -> BannerCollectionViewCell {
        
        var cell: BannerCollectionViewCell?
        cell = dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell
        if cell == nil {
            registerCrossAdsCells()
            cell = dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell
        }
        cell?.presentation = Presentation(adModel: crossAd, placeholderImage: placeholderImage, adHeight: height)
        return cell ?? BannerCollectionViewCell()
    }
}
