# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
use_frameworks!
workspace 'CrossPromotionWithFirebase'

def firebasePods
  pod 'FirebaseAnalytics'
  pod 'FirebaseRemoteConfig'
  pod 'Kingfisher', '~> 7.2'
end

target 'CrossPromotionWithFirebase' do
  project 'CrossPromotionWithFirebase'
  firebasePods
end

target 'CrossAdsSDK' do
  project 'CrossAdsSDK/CrossAdsSDK'
  firebasePods
end
