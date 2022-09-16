# Cross Promotion with firebase config

Promote your apps for free, the idea is about adding native ads fetched from firebase configfuration to your application, and then you can show many types of ads, and all of analysis of ad click and view logged to firebase analytics

![](screenshot.png)


### Why Firebase Configuration?
- To take advantage of custumizing you ads per country or device, .....
- To get the analytics of the ads tap/view on the same firebase anayltics

## Ad Types
### "bannerImage"

![](BannerImage.png)
-----

### "detaildBanner"

![](BannerDetails.png)
-----

### "medium"

![](MediumAds.png)
-----

### "interstitial"

![](screenshot-interstitial.png)
-----

### "bannerImageCollectionView"

![](bannerImageCollectionView.png)
-----


### Add Pod   
```sh
pod 'CrossAdsSDK', :git => 'https://github.com/mfa01/CrossAdsWithFirebase.git', :tag => '0.0.2'
```

#### Also you can specify the tag to back to older versions
```sh
pod 'CrossAdsSDK', :git => 'https://github.com/mfa01/CrossAdsWithFirebase.git', :tag => '0.0.2'
```
```sh
import CrossAdsSDK
```

## Pre Requeirments
- Make sure to have firebase sdk in your project
- Firebase was configured in appdelegate
- Firebase plist file inculuded
- Create firebase remote config, name your config as, ex : "MyAppXCrossAds" with JSON data type 
Note: this name will be used later...
- Add this content sample to the remote config flag, then publish changes
```sh
[
  {
    "id": "adspace",
    "image": "https://i2.wp.com/www.day-today.co.uk/wp-content/uploads/2019/02/advertise-here-banner.jpg?ssl=1",
    "url": "https://lynxmob.com/contact-us",
    "type": "bannerImage",
    "view_freq": 5,
    "click_freq": 1,
    "backgroundColor": "0x3BD6F5",
    "height": 100
  },
  {
    "id": "test-full-banner-twitter-page-elon-musk",
    "image": "https://openseauserdata.com/files/1bbcc86ea8e8927f2b2553bb6120dbc9.jpg",
    "url": "twitter://user?screen_name=elonmusk",
    "backupUrl": "https://www.twitter.com/elonmusk",
    "type": "bannerImage",
    "view_freq": 5,
    "click_freq": 1,
    "backgroundColor": "0x3BD6F5",
    "height": 70
  },
  {
    "id": "iqraa-app-appstore",
    "image": "https://firebasestorage.googleapis.com/v0/b/testproject-a31e1.appspot.com/o/ads%2FBannerIcon%20300x300.jpeg?alt=media&token=2f48a2dd-96f5-4b5b-9305-a4a7b414579c",
    "title": "Iqraa-PDF-whatsapp",
    "subTitle": "Download 1.5 Millions of books for free :D",
    "actionButtonTitle": "Install",
    "url": "https://apps.apple.com/us/app/id1084196602",
    "type": "detaildBanner",
    "view_freq": 5,
    "click_freq": 1,
    "backgroundColor": "0xFFFFFF"
  },
  {
    "id": "pizza-app-appstore",
    "image": "https://firebasestorage.googleapis.com/v0/b/testproject-a31e1.appspot.com/o/ads%2FMediumSizeIcon300x300.png?alt=media&token=d3867eb9-0cbc-4500-8af5-5790a3cf8ab6",
    "mainImage": "https://firebasestorage.googleapis.com/v0/b/testproject-a31e1.appspot.com/o/ads%2FMediumSize900x600.jpeg?alt=media&token=175eb169-2aa1-44a7-b5e2-45987fa85211",
    "title": "Order Now!",
    "subTitle": "We deliver all orders for you",
    "actionButtonTitle": "Install App",
    "url": "https://apps.apple.com/us/app/hungerstation/id596011949",
    "type": "medium",
    "view_freq": 5,
    "click_freq": 1,
    "backgroundColor": "0xF8F0E3"
  },
  {
    "id": "test-full-banner-camp",
    "image": "https://neilpatel.com/wp-content/uploads/2021/02/ExamplesofSuccessfulBannerAdvertising-700x420.jpg",
    "url": "https://www.iqraalibrary.com/",
    "type": "bannerImageCollectionView",
    "view_freq": 5,
    "click_freq": 1,
    "backgroundColor": "0x3BD6F5"
  },
  {
    "id": "pizza-app-appstore-interstitial",
    "image": "https://firebasestorage.googleapis.com/v0/b/testproject-a31e1.appspot.com/o/ads%2FMediumSizeIcon300x300.png?alt=media&token=d3867eb9-0cbc-4500-8af5-5790a3cf8ab6",
    "mainImage": "https://firebasestorage.googleapis.com/v0/b/testproject-a31e1.appspot.com/o/ads%2FMediumSize900x600.jpeg?alt=media&token=175eb169-2aa1-44a7-b5e2-45987fa85211",
    "title": "Order Now!",
    "subTitle": "We deliver all orders for you",
    "actionButtonTitle": "Install App",
    "url": "https://apps.apple.com/us/app/hungerstation/id596011949",
    "type": "interstitial",
    "view_freq": 5,
    "click_freq": 1,
    "backgroundColor": "0xF8F0E3"
  }
]
```

## Now let's start fetching Ads

```sh
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = CrossAdsConfigration(analyticsEnabled: true, analyticsLogTitle: "TestCrossAds", configName: "MyAppXCrossAds")
            CrossAds.shared.start(config: config) { [weak self ] (ads, remoteConfig, error) in
            print(ads)
        }
    }
```

## Let's show your cross ads inside your app

### Showing first interstitial ad in your interstitial cross ads list
```sh
    let interstitialAd = CrossAds.shared.adsInterstitialType.first
    if let interstitialAd = interstitialAd {
        CrossAdsInterstitialViewController.showAd(adModel: interstitialAd, placeholderImage: nil, inVC: self)
    }
```
![](screenshot-interstitial.png)


## Showing Ad in UITableView
### Types can be shown in UITableView: "bannerImage", "detaildBanner" and "medium"
Once you fetched the ad list from firebase config, then you can show the ads on your table view by specifying the cell like this

```var crossAds: [CrossAdModel] = []```
```let cell = tableView.dequeueCrossAdsCell(crossAd: crossAds[indexPath.row], placeholderImage: nil, height: nil)```

to let sdk choose your ad
```
        let ad = CrossAdsManager.shared.pickAdItem()
        let cell = tableView.dequeueCrossAdsCell(crossAd: ad, placeholderImage: nil, height: nil)``` 


## Make you cell item model confirm to Advertizable protocol

## Whenever you want to show an ad in your tableView
```sh
let cell = tableView.dequeueCrossAdsCell(crossAd: crossAds[indexPath.row], placeholderImage: nil, height: nil)
```
'height' field, can be set for ads cell to manually set the height, keep it nil to handle it automattically


![](screenshot.png)

## Ad Model
    public var id: String
    public var image: String?
    public var mainImage: String?
    public var title: String?
    public var actionButtonTitle: String?
    public var subTitle: String?
    public var type: CrossAdType?
    public var url: String?
    public var view_freq: Int?
    public var click_freq: Int?
    public var backgroundColor: String?
    public var allowDismissAfter: Double?


## Firebase Configuration

## Firebase Analytics Configuration





```sh
    let vc = YPlayerWebViewViewController.initPlayer(delegate: self)
    let videoPresenetation = VideoPlayerPresentaion(videoId: "668nUCeBHyY")
    self.present(vc, animated: true) {
        vc.openPageWithVideoId(presentation: videoPresenetation)
    }
```
 ##### Always you can add many options to the presentation struct
 - let videoId: String
 - var autoplay = 1
 - var controls = 1 // show video controls options
 - var color: PlayerColor = .red
 - var playsinline = 1
 - var start: Float = 0.0 // start time
 - var loop = 0
 - var rel = 0 // show related videos after video end
 - var fs = 1 // show full screen option
 - var modestbranding = 0 // show youtube colors
 
## Open youtube with searched text

![](video1.gif)


```sh
    let vc = YPlayerWebViewViewController.initPlayer(delegate: nil)
    vc.webviewType = .searching
    self.present(vc, animated: true) {
        var c = URLComponents(string: "https://www.youtube.com/results")
        c?.queryItems = [
            URLQueryItem(name: "search_query", value: text)
        ]
        guard let url = c?.url else { return print("url fail") }
        vc.openPage(url: url)
    }
```
## Features
```sh
    func getCurrentTime(handler: @escaping (Float?) -> Void)
    func seekTo(time: Float)
    func mute()
    func unMute()
    func isMuted(handler: @escaping (Bool?) -> Void)
    func setVolume(volume: Int)
    func getVolume(handler: @escaping (Int?) -> Void)
    func setPlaybackRate(value: Float)
    func getPlaybackRate(handler: @escaping (Float?) -> Void)
    func getAvailablePlaybackRates(handler: @escaping ([Float]?) -> Void)
    func setLoop(value: Float)
    func setShuffle(value: Float)
    func getVideoLoadedFraction(handler: @escaping (Float?) -> Void)
    func getPlayerState(handler: @escaping (PlayerState) -> Void)
    func getDuration(handler: @escaping (Float?) -> Void)
    func getVideoEmbedCode(handler: @escaping (Float?) -> Void)
    func playVideo()
    func stopVideo()
    func pauseVideo()
    func getIframe()
```
    
    
# for referance https://developers.google.com/youtube/iframe_api_reference
