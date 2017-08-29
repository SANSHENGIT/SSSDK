#
#  Be sure to run `pod spec lint SSSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SSSDK"
  s.version      = "0.0.2"
  s.summary      = "Shenzhen City Sansheng Techonlogy LLC"  
  s.description  = <<-DESC
                            SSSDK 来源于三竔科技封装
                   DESC

  s.homepage     = "https://github.com/SANSHENGIT/SSSDK"
  s.license      = 'MIT'
  s.author       = "LIFEIHENG"
  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/SANSHENGIT/SSSDK.git", :tag => "#{s.version}" }
  s.source_files  = "SSSDK/*"
  s.frameworks = "UIKit","AudioToolbox","AVKit","CFNetwork","CoreAudio","CoreAudioKit","CoreImage","CoreMedia","JavaScriptCore"
  s.requires_arc = true

  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  s.dependency "YYModel", "~> 1.0.4"
  s.dependency "GTMBase64"
  # s.dependency "IQKeyboardManager"
  # s.dependency "AMapLocation"
  s.dependency "AFNetworking"
  s.dependency "SDWebImage"
  

end
