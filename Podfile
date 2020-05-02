source 'https://github.com/CocoaPods/Specs.git'

pod 'SwiftLint'

target 'Caduceus' do
  platform :ios, '9.0'
  use_frameworks!

  pod 'AWSCognitoIdentityProvider'
  pod 'AWSKinesisVideo'
  pod 'AWSKinesisVideoSignaling'
  pod 'AWSMobileClient'

  target 'CaduceusTests' do
    inherit! :search_paths
  end
end
