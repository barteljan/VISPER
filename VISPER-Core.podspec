Pod::Spec.new do |s|
  s.name             = 'VISPER-Core'
  s.version          = '5.0.0'
  s.summary          = 'The core protocols and classes used in the VISPER Framework.'

  s.description      = <<-DESC
The core protocols and classes used in the VISPER Framework.
(VISPER is a framework for building component based apps with the viper architecture).
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Core-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.source_files = 'VISPER-Core/Classes/**/*'
  

end
