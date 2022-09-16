//
//  ViewController.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 27/06/2022.
//

import UIKit
import CrossAdsSDK

struct SampleStruct: Advertizable {
    var isCrossAd: Bool? = false
    var name: String
    var age: String
    var city: String
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var tableItems: [Advertizable] = {
        var items: [SampleStruct] = []
        for index in 0...200 {
            let value = SampleStruct(name: "My name is \(index)", age: "\(arc4random()%100)", city: "My City: \(arc4random()%100)")
            items.append(value)
        }
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = CrossAdsConfigration(analyticsEnabled: true, analyticsLogTitle: "TestCrossAds", configName: "MyAppXCrossAds")
        collectionView.delegate = self
        collectionView.registerCrossAdsCells()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            CrossAds.shared.start(config: config) { [weak self ] (ads, remoteConfig, error) in
                
                // Example1 : Fill ads manually
                //self?.fillCrossAds()
                
                // Example2 : Fill ads automatically, need implement willdisplay delegate
                
                self?.tableView.reloadData()
                self?.collectionView.reloadData()
            }
        }
        
    }
    
    func fillCrossAds() {
        // WANT to fill bannerImage at index 0
        // WANT to fill detaildBanner at index 7
        // WANT to fill interstitial at index 11
        // WANT to fill medium at index 20
        // WANT to fill bannerImage at index 29
        if let ad = CrossAds.shared.pickAdItem(type: .bannerImage) {
            tableItems.insert(ad, at: 0)
        }
        if let ad = CrossAds.shared.pickAdItem(type: .detaildBanner), tableItems.count > 7 {
            tableItems.insert(ad, at: 7)
        }
        if let ad = CrossAds.shared.pickAdItem(type: .interstitial), tableItems.count > 11 {
            tableItems.insert(ad, at: 11)
        }
        if let ad = CrossAds.shared.pickAdItem(type: .medium), tableItems.count > 20 {
            tableItems.insert(ad, at: 20)
        }
        if let ad = CrossAds.shared.pickAdItem(type: .bannerImage), tableItems.count > 29 {
            tableItems.insert(ad, at: 29)
        }
    }
    
    func fillAllCrossAds() {
        tableItems.insert(contentsOf: CrossAds.shared.items, at: 0)
    }

    @IBAction func showInterstitialAds(_ sender: Any) {
        let interstitialAd = CrossAds.shared.adsInterstitialType.first
        if let interstitialAd = interstitialAd {
            CrossAdsInterstitialViewController.showAd(adModel: interstitialAd, placeholderImage: nil, inVC: self)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let ad = CrossAds.shared.pickAdItem(),
           indexPath.row%9 == 0,
           indexPath.row > 0,
           tableItems[indexPath.row].isCrossAd == false {
            tableItems.insert(ad, at: indexPath.row)
            tableView.reloadData()
            CrossAds.shared.dropAdItem(type: ad.type)
        }
        
        let item = tableItems[indexPath.row]
        if let item = item as? CrossAdModel {
            let cell = tableView.dequeueCrossAdsCell(crossAd: item, placeholderImage: nil)
            return cell
        }
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = (item as? SampleStruct)?.name
        cell.detailTextLabel?.text = ((item as? SampleStruct)?.age ?? "") + "index:\(indexPath.row)"
        return cell
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueBannerCell(crossAd: CrossAds.shared.adsBannerCollectionViewType[indexPath.row], placeholderImage: nil, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CrossAds.shared.adsBannerCollectionViewType.count
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}

extension ViewController: UICollectionViewDelegate {
    
}
