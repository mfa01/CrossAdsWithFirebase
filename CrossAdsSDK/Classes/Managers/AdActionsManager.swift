//
//  AdActionsManager.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 17/07/2022.
//

import Foundation
import UIKit

class AdActionsManager {
    
    static func adTapped(adModel: CrossAdModel?) {
        if let urlString = adModel?.url, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
        CrossAdsLogger.shared.adTapped(adModel: adModel)
    }
    
    static func adViewed(adModel: CrossAdModel?) {
        CrossAdsLogger.shared.adViewed(adModel: adModel)
    }
}
