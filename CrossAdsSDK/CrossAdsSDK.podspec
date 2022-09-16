Pod::Spec.new do |s|
    s.name              = 'CrossAdsSDK'
    s.version           = '0.0.1'
    s.summary           = 'Cross ads sdk, by firebase config power'
    s.homepage          = 'http://lynxmob.com/'
    s.dependency       'FirebaseAnalytics'
    s.dependency       'FirebaseRemoteConfig'
    s.dependency       'Kingfisher', '~> 7.2'

    s.author            = { 'mohammad alabed' => 'mfa01@yahoo.com' }
    # s.license           = { :type => 'MIT', :file => 'LICENSE.md' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/mfa01/CrossAdsWithFirebase/tree/main/CrossAdsSDK.git',:tag => s.version}

    s.ios.deployment_target = '13.0'
    #s.ios.vendored_frameworks = 'CrossAdsSDK.xcframework'
    # s.vendored_frameworks = 'ExternalFrameworks/CardinalMobile.xcframework'
    s.requires_arc = true
    s.swift_version = '5.0'
    s.source_files = 'Classes/**/*'
end
