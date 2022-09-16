Pod::Spec.new do |s|
    s.name              = 'CrossAdsSDK'
    s.version           = '0.0.5'
    s.summary           = 'Cross ads sdk, by firebase config power'
    s.homepage          = 'http://lynxmob.com/'
    s.dependency       'FirebaseAnalytics'
    s.dependency       'FirebaseRemoteConfig'
    s.dependency       'Kingfisher', '~> 7.2'

    s.author            = { 'mohammad alabed' => 'info@ylynxmob.com' }
    # s.license           = { :type => 'MIT', :file => 'LICENSE.md' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/mfa01/CrossAdsWithFirebase.git',:tag => s.version}
    s.static_framework = true

    s.ios.deployment_target = '12.0'
    # s.ios.vendored_frameworks = 'CrossAdsSDK/CrossAdsSDK.xcframework'
    s.requires_arc = true
    s.swift_version = '5.0'
    # s.source_files = 'CrossAdsSDK/Classes/**/*'
    # s.source_files = 'CrossAdsSDK/Classes/**/*.{h,m}'
    s.source_files = 'CrossAdsSDK/CrossAdsSDK/Classes/**/*.{h,m}'
    s.resource_bundles = {
      'MyPodBundle' => ['CrossAdsSDK/CrossAdsSDK/Resources/**/*.xib']
    }
end
