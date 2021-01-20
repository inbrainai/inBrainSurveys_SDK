Pod::Spec.new do |s|

  s.name         = "InBrainSurveys"
  s.version      = "1.5.3"
  s.summary      = "Monetization surveys for apps, powered by inBrain.ai."
  s.description  = "In-App monetization via surveys, powered by inBrain.ai."

  s.homepage     = "https://github.com/inbrainai/inBrainSurveys_SDK"
  s.license      = { :type => "MIT", :file => "License" }
  s.author       = { "Sergey Blazhko" => "sergey@inbrain.ai" }

  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/inbrainai/inBrainSurveys_SDK.git", :tag => s.version }
  s.source_files = "InBrainSurveys_SDK_Swift.xcframework/*/*.framework/Headers/*.h"
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.vendored_frameworks = "InBrainSurveys_SDK_Swift.xcframework"
  s.ios.frameworks = 'UIKit', 'Foundation', 'SystemConfiguration', 'WebKit'

end

