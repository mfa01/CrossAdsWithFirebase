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
        let num = AdsCacheManager.shared.numberAdTapping(id: adModel?.id)
        if let freq = adModel?.click_freq, freq >= num.intValue {
            AdsCacheManager.shared.adTapped(id: adModel?.id)
            CrossAdsLogger.shared.logTappingEvent(id: adModel?.id)
        }
        if let urlString = adModel?.url, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
        print("AdActionsManager: Ad Tapped \(adModel?.id ?? "-")")
    }
    
    static func adViewed(adModel: CrossAdModel?) {
        let num = AdsCacheManager.shared.numberOfAdViewing(id: adModel?.id)
        if let freq = adModel?.view_freq, freq >= num.intValue {
            print("AdActionsManager: Ad Viewed \(adModel?.id ?? "-")")
            CrossAdsLogger.shared.logViewEvent(id: adModel?.id)
            AdsCacheManager.shared.adViewed(id: adModel?.id)
        }
    }
}
