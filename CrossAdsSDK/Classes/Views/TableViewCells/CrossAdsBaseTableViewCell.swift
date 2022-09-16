//
//  CrossAdsBaseTableViewCell.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 28/06/2022.
//

import Foundation
import UIKit

public struct Presentation {
    public var adModel: CrossAdModel?
    public var placeholderImage: UIImage?
    public var adHeight: CGFloat?
}

protocol CrossAdsBaseCellDelegate {
    func adTapped(adModel: CrossAdModel?)
}

public class CrossAdsBaseTableViewCell: UITableViewCell {
    
    var delegate: CrossAdsBaseCellDelegate?
    
    var presentation: Presentation? {
        didSet {
            setBackgroundColor(color: presentation?.adModel?.backgroundColor)
            AdActionsManager.adViewed(adModel: presentation?.adModel)
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.adTapped (_:)))
        self.contentView.addGestureRecognizer(gesture)
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setBackgroundColor(color: String?) {
        if let color = color, let floatColor = Float64(color) {
            let rgbInt = Int(UInt32(floatColor))
            contentView.backgroundColor = UIColor(rgb: rgbInt)
        }
    }
    
    @objc func adTapped(_ sender:UITapGestureRecognizer){
        // do other task
        delegate?.adTapped(adModel: presentation?.adModel)
        adTapped()
    }
    
    func adTapped() {
        AdActionsManager.adTapped(adModel: presentation?.adModel)
    }
}

extension UITableViewCell {
    @objc static var identifier: String {
        String(describing: self)
    }
}
