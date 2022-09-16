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
