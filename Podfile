# Uncomment this line to define a global platform for your project
platform :ios, ’10.0’

target 'SUSquare' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SUSquare
  pod 'Alamofire', '~> 4.0'
  pod 'SwiftyJSON'
  pod 'SVProgressHUD'
  pod 'Fabric'
  pod 'Digits'
  pod 'TwitterCore'
  pod 'MZFormSheetPresentationController'
  pod 'Cosmos', '~> 7.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
