#
# Be sure to run `pod lib lint InApp.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "InApp"
  s.version          = "0.1.1"
  s.summary          = "SDK for Klarna's InApp purchases."
#s.description      = <<-DESC
#                       An optional longer description of InApp
#
#                       * Markdown format.
#                       * Don't worry about the indent, we strip it!
#                       DESC
  s.homepage         = "https://github.com/<GITHUB_USERNAME>/InApp"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Klarna" => "???@klarna.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/InApp.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'inapp/**/*.{m,h}', '3rdParty/**/*.{m,h}'
  s.resource_bundles = {
    'KIA' => 'inapp/KIA.bundle/*.lproj'
  }
  s.xcconfig = { "OTHER_LDFLAGS" => "-ObjC -all_load"  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end