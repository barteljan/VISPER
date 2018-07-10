 #
# Be sure to run `pod lib lint SwiftyVISPER.podspec' to ensure this is a
# valid spec before submitting.
Pod::Spec.new do |s|
  s.name             = 'VISPER-Swift'
  s.version          = '2.2.1'
  s.summary          = 'VISPER is a framework for building component based apps with the viper architecture'

  s.description      = <<-DESC
VISPER is a framework for building component based apps with the viper architecture in swift.
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Swift-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.ios.deployment_target = '8.0'

  s.dependency 'VISPER-Core','~> 2.1.0'
  s.dependency 'VISPER-Objc','~> 2.1.0'
  s.dependency 'VISPER-Presenter','~> 2.1.0'
  s.dependency 'VISPER-Wireframe','~> 2.1.0'
  s.dependency 'VISPER-Redux','~> 2.2.2'
  s.dependency 'VISPER-Entity','~> 1.1.0'

  s.source_files = 'VISPER-Swift/Classes/**/*.swift'
end
