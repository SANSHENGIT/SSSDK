#
#  Be sure to run `pod spec lint SSSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  数据规范  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #


  s.name         = "SSSDK"
  s.version      = "0.0.1"
  s.summary      = "Shenzhen City Sansheng Techonlogy LLC"

  # 这个描述是用于生成标签和提高搜索结果。
  
  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/SANSHENGIT/SSSDK"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  规范许可  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  #s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― 作者  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # s.author             = { "LIFEIHENG" => "admin@sanshengit.com" }
  s.author    = "LIFEIHENG"
  # s.authors            = { "李飞恒" => "admin@sanshengit.com" }
  # s.social_media_url   = "http://sanshengit.com"

  # ――― 全用系统(ios, OS X) ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― 源地址 ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #  支持 git, hg, bzr, svn and HTTP.

  s.source       = { :git => "https://github.com/SANSHENGIT/SSSDK.git", :tag => "#{s.version}" }


  # ――― 源代码 ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "SSSDK", "SSSDK/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― 链接库与框架 ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  s.frameworks = "UIKit","AudioToolbox","AVKit","CFNetwork","CoreAudio","CoreAudioKit","CoreImage","CoreMedia","JavaScriptCore",
  "UserNotificationsUI","UserNotifications","VideoSubscriberAccount","AVFoundation","CoreFoundation"

  # s.libraries = "libsqlite3","libc++","libz","libc","libsandbox","libstdc++","libSystem"


  # ――― 项目设置 ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # # s.dependency "JSONKit", "~> 1.4"
  # s.dependency "YYModel"
  # s.dependency "GTMBase64"
  # s.dependency "MJRefresh"
  # s.dependency "IQKeyboardManager"
  # s.dependency "AMapLocation"
  # s.dependency "AFNetworking"
  # s.dependency "SDWebImage"
  

end
