Pod::Spec.new do |spec|
  spec.name         = "paytmIntegration"
  spec.version      = "1.0.0"
  spec.swift_version = "5.0"
  spec.summary      = "Integrating paytm in your iOS app."
  spec.description  = "This is to integrate paytm in your iOS apps."
  spec.platform     = :ios, "15.0"
  spec.ios.deployment_target  = '15.0'
  spec.homepage     = "https://github.com/MageNative-Team/paytm.git"
  spec.license      = "MIT"
  spec.author             = { "Komal15B" => "komalbachani@magenative.com" }  
  spec.source       = { :git => "https://github.com/MageNative-Team/paytm.git", :tag => "#{spec.version}" }
  spec.source_files  = "paytm/**/*"
  spec.framework  = "UIKit"
end

