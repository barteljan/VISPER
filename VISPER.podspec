#
# Be sure to run `pod lib lint VISPER.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "VISPER"
  s.version          = "0.1.16"
  s.summary          = "A iOS library to support the VIPER architecture in iOS-Apps"
  s.description      = <<-DESC
                       A iOS library to support the VIPER architecture in iOS-Apps.

                       Contains some base classes to design VIPER based iOS-Apps.
                       The framework includes a basic class for viewcontrollers, presenters, interactors and a wireframe
DESC
  s.homepage         = "https://github.com/barteljan/VISPER"
  s.license          = 'MIT'
  s.author           = { "Jan Bartel" => "barteljan@yahoo.de" }
  s.source           = { :git => "https://github.com/barteljan/VISPER.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'VISPER' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'JLRoutes', '~> 1.5.2'
end
