//
//  CrossAdsDetailedBannerTableViewCell.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 28/06/2022.
//

import UIKit

class CrossAdsDetailedBannerTableViewCell: CrossAdsBaseTableViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var heighConstraint: NSLayoutConstraint!
    
    override var presentation: Presentation? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        guard let presentation = presentation, let model = presentation.adModel else {
            return
        }
        setImage()
        titleLabel.text = model.title
        subtitleLabel.text = model.subTitle
        actionButton.setTitle(model.actionButtonTitle, for: .normal)
        actionButton.layer.cornerRadius = 5
    }
    
    func setImage() {
        if let imagePath = presentation?.adModel?.image {
            if let url = URL(string: imagePath) {
                bannerImageView.kf.setImage(with: url, placeholder: presentation?.placeholderImage)
            }
        } else {
            bannerImageView.image = presentation?.placeholderImage
        }
        bannerImageView.layer.cornerRadius = 10
    }
}
