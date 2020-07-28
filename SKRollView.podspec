#
#  Be sure to run `pod spec lint SKRollView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.swift_version = "5.2"  
  spec.name         = "SKRollView"
  spec.version      = "0.0.1"
  spec.summary      = "S一个上下滚动的公告栏"

  spec.description  = <<-DESC
  一个上下滚动的公告栏,通常用在 APP 的首页
                   DESC

  spec.homepage     = "https://github.com/shenkaiqiang/SKRollView"

  spec.license      = "MIT"
  
  spec.author             = { "shenkaiqiang" => "1187159671@qq.com" }
 
  spec.platform     = :ios, "11.0"

  #  When using multiple platforms
  spec.ios.deployment_target = "11.0"

  spec.source       = { :git => "https://github.com/shenkaiqiang/SKRollView.git", :tag => "#{spec.version}" }

  spec.source_files  = "SKRollView/*.swift"
  
  spec.requires_arc = true

end
