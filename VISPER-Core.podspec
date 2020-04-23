#
# Be sure to run `pod lib lint VISPER-Wireframe.podspec' to ensure this is a

Pod::Spec.new do |s|
  s.name             = 'VISPER-Core'
  s.version          = '4.0.1'
  s.summary          = 'The core protocols and classes used in the VISPER Framework.'

  s.description      = <<-DESC
The core protocols and classes used in the VISPER Framework.
(VISPER is a framework for building component based apps with the viper architecture).
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER-Wireframe'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Core-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'

  s.source_files = 'VISPER-Core/Classes/**/*'
  

end
