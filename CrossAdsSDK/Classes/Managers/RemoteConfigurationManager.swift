//
//  CrossAdsConfigModel.swift
//  Pdf_Tab
//
//  Created by Mabed on 18/05/2022.
//  Copyright © 2022 lynxmob. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

class RemoteConfigurationManager: NSObject {
    
    private var remoteConfig = RemoteConfig.remoteConfig()

    func getConfig(configName: String, completion: @escaping (([CrossAdModel]?, RemoteConfig?, Error?)->())) {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 1
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate { changed, error in
                let value = self.remoteConfig.configValue(forKey: configName).dataValue
                do {
                    let model = try JSONDecoder().decode([CrossAdModel].self, from: value)
                    completion(model,self.remoteConfig,nil)
                    print("MainTopBanner \(value)")
                } catch let error {
                    completion(nil,nil,error)
                }
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
              completion(nil,nil,error)
          }
        }
    }
}
