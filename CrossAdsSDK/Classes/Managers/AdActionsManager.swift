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
        if let first = adModel?.url,
           let firstUrl = URL(string: first) {
            let application = UIApplication.shared
            if application.canOpenURL(firstUrl) {
                application.open(firstUrl)
            } else if let backup = adModel?.backupUrl, let backupUrl = URL(string: backup) {
                application.open(backupUrl)
            }
        }
        CrossAdsLogger.shared.adTapped(adModel: adModel)
    }
    
    static func adViewed(adModel: CrossAdModel?) {
        CrossAdsLogger.shared.adViewed(adModel: adModel)
    }
}
