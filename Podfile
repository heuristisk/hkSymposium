source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def common_pods
    pod 'SwiftLint'
    pod 'Alamofire', '~> 4.5'
    pod 'AlamofireObjectMapper', '~> 5.0'
    pod 'Kingfisher', '~> 4.0'
end

workspace 'hkSymposium'

target 'hkSymposium' do
	xcodeproj 'hkSymposium.xcodeproj'
    common_pods
end

workspace 'hkSymposium'

target 'hkSymposiumTests' do
	xcodeproj 'hkSymposium.xcodeproj'
    common_pods
end

workspace 'hkSymposium'

target 'TMDbClient' do
	xcodeproj 'TMDbClient/TMDbClient.xcodeproj'
    common_pods
end
