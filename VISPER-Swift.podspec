Pod::Spec.new do |s|
  s.name             = 'VISPER-Swift'
  s.version          = '5.0.0'
  s.summary          = 'VISPER is a framework for building component based apps with the viper architecture'

  s.description      = <<-DESC
VISPER is a framework for building component based apps with the viper architecture in swift.
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Swift-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.ios.deployment_target = '13.0'
  s.swift_version = '4.2'

  s.dependency 'VISPER-Core','~> 5.0.0'
  s.dependency 'VISPER-Objc','~> 5.0.0'
  s.dependency 'VISPER-Presenter','~> 5.0.0'
  s.dependency 'VISPER-Wireframe','~> 5.0.0'
  s.dependency 'VISPER-Redux','~> 5.0.0'
  s.dependency 'VISPER-Entity','~> 5.0.0'

  s.source_files = 'VISPER-Swift/Classes/**/*.swift'
end
