source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!

pod 'SwiftLint'

target 'Caduceus' do
  platform :ios, '13.0'
  use_frameworks!

  pod 'AWSCognitoIdentityProvider'
  pod 'AWSKinesisVideo'
  pod 'AWSKinesisVideoSignaling'
  pod 'AWSMobileClient'
  pod 'CombineStore', :path => 'Libraries/CombineStore'

  target 'CaduceusTests' do
    inherit! :search_paths
  end
end
