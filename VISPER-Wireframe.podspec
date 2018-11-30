#
# Be sure to run `pod lib lint VISPER-Wireframe.podspec' to ensure this is a

Pod::Spec.new do |s|
  s.name             = 'VISPER-Wireframe'
  s.version          = '3.1.7'
  s.summary          = 'Implementation of viper wireframe layer in the VISPER Application Framework'

  s.description      = <<-DESC
Implementation of viper wireframe layer in the VISPER Application Framework.
VISPER is a framework for building component based apps with the viper architecture in swift.
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Wireframe-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.0'
  s.source_files = 'VISPER-Wireframe/Classes/**/*'

  s.dependency 'VISPER-Core','~> 3.0.1'
  s.dependency 'VISPER-Objc','~> 3.0.0'
  s.dependency 'VISPER-Presenter','~> 3.0.0'
  s.dependency 'VISPER-UIViewController','~> 3.0.0'

end
