//
//  BannerCollectionViewCell.swift
//  CrossAdsSDK
//
//  Created by Mabed on 15/09/2022.
//

import UIKit

public class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!

    static var identifier = "BannerCollectionViewCell"

    var presentation: Presentation? {
        didSet {
            updateUI()
            AdActionsManager.adViewed(adModel: presentation?.adModel)
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
        setBackgroundColor(color: presentation.adModel?.backgroundColor)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.adTapped (_:)))
        contentView.addGestureRecognizer(gesture)
    }
   
    func setBackgroundColor(color: String?) {
        if let color = color, let floatColor = Float64(color) {
            let rgbInt = Int(UInt32(floatColor))
            contentView.backgroundColor = UIColor(rgb: rgbInt)
        }
    }
    
    @objc func adTapped(_ sender:UITapGestureRecognizer){
        // do other task
        adTapped()
    }
    
    func adTapped() {
        AdActionsManager.adTapped(adModel: presentation?.adModel)
    }
}
