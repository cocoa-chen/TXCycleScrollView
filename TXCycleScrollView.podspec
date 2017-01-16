Pod::Spec.new do |s|
  s.name         = "TXCycleScrollView"
  s.version      = "0.0.1"
  s.summary      = "Infinite ScrollView with autoScroll."
  s.description  = <<-DESC
                  Auto scroll infinite banner for iOS.
                   DESC
  s.homepage     = "https://github.com/cocoa-chen/TXCycleScrollView.git"
  s.license      = "MIT"
  s.author             = { "陈爱彬" => "cocoa_chen@126.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/cocoa-chen/TXCycleScrollView.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h"
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "SDWebImage"

end
