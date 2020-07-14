Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "InBrainSurveys"
  spec.version      = "1.2.0"
  spec.summary      = "Monetization surveys for apps, powered by inBrain.ai."

  spec.description  = "In-App monetization via surveys, powered by inBrain.ai."

  spec.homepage     = "https://github.com/inbrainai/inBrainSurveys_SDK"

  spec.license      = { :type => "MIT", :file => "LICENSE"}

  spec.author       = { "Joel Myers" => "joel@inbrain.ai" }

  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/inbrainai/inBrainSurveys_SDK.git", :tag => "1.2.0" }
  spec.source_files = "InBrainSurveys_SDK_Swift.xcframework/ios-armv7_arm64/InBrainSurveys_SDK_Swift.framework/Headers/*.h", "InBrainSurveys_SDK_Swift.xcframework/ios-i386_x86_64-simulator/InBrainSurveys_SDK_Swift.framework/Headers/*.h"
  spec.vendored_frameworks = "InBrainSurveys_SDK_Swift.xcframework"
  

end

