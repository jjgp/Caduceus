source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!

pod 'SwiftLint'

target 'Caduceus' do
  platform :ios, '13.0'
  use_frameworks!

  pod 'AWSCognitoIdentityProvider'
  pod 'AWSMobileClient'
  pod 'CombineStore', :path => 'libraries/CombineStore'

  target 'CaduceusTests' do
    inherit! :search_paths
  end
end
