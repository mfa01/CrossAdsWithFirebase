//
//  CrossAdsLogger.swift
//  Pdf_Tab
//
//  Created by Mabed on 08/06/2022.
//  Copyright © 2022 lynxmob. All rights reserved.
//

import Foundation
import FirebaseAnalytics

struct CrossAdsLogger {
    
    static var shared = CrossAdsLogger()
    
    func logViewEvent(id: String?) {
        guard let id = id else {
            return
        }
        let configName = CrossAds.shared.config?.configName ?? ""
        Analytics.logEvent("CrossAds-\(configName)", parameters: [
          AnalyticsParameterItemID: "\(configName)-View \(id)",
          AnalyticsParameterItemName: "Ad View",
          AnalyticsParameterContentType: "View",
        ])
    }
    func adViewed(adModel: CrossAdModel?) {
        let num = AdsCacheManager.shared.numberOfAdViewing(id: adModel?.id)
        if let freq = adModel?.view_freq, freq >= num.intValue {
            print("AdActionsManager: Ad Viewed \(adModel?.id ?? "-")")
            logViewEvent(id: adModel?.id)
            AdsCacheManager.shared.adViewed(id: adModel?.id)
        }
    }
    
    func adTapped(adModel: CrossAdModel?) {
        let num = AdsCacheManager.shared.numberAdTapping(id: adModel?.id)
        if let freq = adModel?.click_freq, freq >= num.intValue {
            AdsCacheManager.shared.adTapped(id: adModel?.id)
            logTappingEvent(id: adModel?.id)
        }
    }
    func logTappingEvent(id: String?) {
        guard let id = id else {
            return
        }
        let configName = CrossAds.shared.config?.configName ?? ""
        Analytics.logEvent("CrossAds-\(configName)", parameters: [
          AnalyticsParameterItemID: "\(configName)-Click \(id)",
          AnalyticsParameterItemName: "Ad Click",
          AnalyticsParameterContentType: "Click",
        ])
    }
}
