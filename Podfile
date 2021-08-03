# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LocationListing' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SnapKit', '~> 5.0.0'
  pod 'Moya', '~> 14.0'
  pod 'GoogleMaps', '= 4.2.0'
  pod 'GooglePlaces', '4.2.0'
  pod 'SwiftLint'
  pod 'SkeletonView', '=1.15.0'
  pod 'SDWebImage'
  pod 'RealmSwift', '=10.7.4'
  pod 'ObjectMapper', '~> 4.2.0'
  pod 'Loaf', '~> 0.7.0'



  # Pods for LocationListing

  target 'LocationListingTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LocationListingUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
  end
end