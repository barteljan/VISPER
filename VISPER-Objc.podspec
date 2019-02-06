#
# Be sure to run `pod lib lint VISPER-Wireframe.podspec' to ensure this is a

Pod::Spec.new do |s|
  s.name             = 'VISPER-Objc'
  s.version          = '3.1.0'
  s.summary          = 'Objc Wrapper of all public VISPER-Wireframe classes.'

  s.description      = <<-DESC
Objc Wrapper of all public VISPER-Wireframe classes.
(VISPER is a framework for building component based apps with the viper architecture in swift.)
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Objc-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.0'

  s.source_files = 'VISPER-Objc/Classes/**/*'
  s.dependency 'VISPER-Core','~> 3.1.0'
  s.dependency 'VISPER-Presenter','~> 3.1.0'

end
