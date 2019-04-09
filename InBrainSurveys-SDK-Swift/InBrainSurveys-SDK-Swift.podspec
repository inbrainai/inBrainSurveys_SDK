#
# Be sure to run `pod lib lint InBrainSurveys-SDK-Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'InBrainSurveys-SDK-Swift'
  s.version          = '0.1.0'
  s.summary          = 'Survey framework to monetize your app'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Survey framework to monetize your app, served up by InBrain.
                       DESC

  s.homepage         = 'https://github.com/inBrainSurveys/inBrain-SDK-iOS-Swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Joel Myers' => 'joel@appsthatpay.co' }
  s.source           = { :git => 'https://github.com/inBrainSurveys/inBrain-SDK-iOS-Swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # s.platform   = ios, '12.0'
  s.ios.deployment_target = '12.0'
  s.source_files = 'InBrainSurveys-SDK-Swift/Classes/**/*'
  s.swift_version = '4.2'
  
  # s.resource_bundles = {
  #   'InBrainSurveys-SDK-Swift' => ['InBrainSurveys-SDK-Swift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
