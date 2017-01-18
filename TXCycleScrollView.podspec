Pod::Spec.new do |s|
  s.name         = "TXCycleScrollView"
  s.version      = "0.0.4"
  s.summary      = "Infinite ScrollView with autoScroll."
  s.description  = <<-DESC
                  Auto scroll infinite banner for iOS.
                   DESC
  s.homepage     = "https://github.com/cocoa-chen/TXCycleScrollView.git"
  s.license      = 'MIT'
  s.author             = { "陈爱彬" => "136998328@qq.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/cocoa-chen/TXCycleScrollView.git", :tag => s.version.to_s }
  s.source_files  = "src/TXCycleScrollView/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
  s.frameworks = 'Foundation','UIKit'
  s.dependency "SDWebImage"

end
