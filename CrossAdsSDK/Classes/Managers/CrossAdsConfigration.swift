//
//  CrossAdsConfigurator.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 27/06/2022.
//

import Foundation

public struct CrossAdsConfigration {
    
    let configName: String
    let analyticsEnabled: Bool
    let analyticsLogTitle: String
    
    public init(analyticsEnabled: Bool = true, analyticsLogTitle: String = "CrossPromotion", configName: String) {
        self.analyticsEnabled = analyticsEnabled
        self.analyticsLogTitle = analyticsLogTitle
        self.configName = configName
    }
}
