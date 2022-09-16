//
//  CrossAdsBannerTableViewCell2.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 12/07/2022.
//

import UIKit
import Kingfisher

class CrossAdsBannerTableViewCell: CrossAdsBaseTableViewCell {

    static var defaultHeight = 60.0
    
    @IBOutlet weak var heighConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override var presentation: Presentation? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        guard let presentation = presentation else {
            return
        }
        if let imagePath = presentation.adModel?.image {
            if let url = URL(string: imagePath) {
                bannerImageView.kf.setImage(with: url, placeholder: presentation.placeholderImage)
            }
        } else {
            bannerImageView.image = presentation.placeholderImage
        }
        heighConstraint.constant = presentation.adHeight ?? CrossAdsBannerTableViewCell.defaultHeight
    }
}
