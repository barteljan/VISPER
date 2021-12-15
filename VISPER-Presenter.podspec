#
# Be sure to run `pod lib lint SwiftyVISPER.podspec' to ensure this is a
# valid spec before submitting.
Pod::Spec.new do |s|
  s.name             = 'VISPER-Presenter'
  s.version          = '4.0.2'
  s.summary          = 'Presenter layer of the VISPER Application Framework'

  s.description      = <<-DESC
Implementation of the presenter layer of the VISPER Application Framework.
(VISPER is a framework for building component based apps with the viper architecture). 
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }

  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Presenter-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.source_files = 'VISPER-Presenter/Classes/**/*'
  s.dependency 'VISPER-Core','~> 4.0.0'
end
