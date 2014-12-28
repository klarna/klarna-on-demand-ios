#
# Be sure to run `pod lib lint KlarnaOnDemand.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "klarna-on-demand"
  s.version          = "0.1.1"
  s.summary          = "SDK for Klarna's on-demand purchases."
#s.description      = <<-DESC
#                       An optional longer description of Klarna on-demand
#
#                       * Markdown format.
#                       * Don't worry about the indent, we strip it!
#                       DESC
  s.homepage         = "https://github.com/klarna/klarna-on-demand-ios"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Klarna" => "index.e@klarna.com" }
  s.source           = { :git => "https://github.com/klarna/klarna-on-demand-ios.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'KlarnaOnDemand/**/*.{m,h}', '3rdParty/**/*.{m,h}'
  s.resource_bundles = {
    'KOD' => 'KlarnaOnDemand/KOD.bundle/*.lproj'
  }
  s.xcconfig = { "OTHER_LDFLAGS" => "-ObjC -all_load"  }
  s.prefix_header_contents = """
  #ifdef __OBJC__
    #import <Foundation/Foundation.h>
    #import \"BDError.h\"
    #import \"BDLog.h\"
  #endif
  """

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
