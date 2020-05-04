source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!

pod 'SwiftLint'

target 'Caduceus' do
  platform :ios, '9.0'
  use_frameworks!

  pod 'AWSCognitoIdentityProvider'
  pod 'AWSKinesisVideo'
  pod 'AWSKinesisVideoSignaling'
  pod 'AWSMobileClient'
  pod 'RxSwift'

  target 'CaduceusTests' do
    inherit! :search_paths
    pod 'RxBlocking'
    pod 'RxTest'
  end
end
