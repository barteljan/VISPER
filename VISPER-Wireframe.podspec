#
# Be sure to run `pod lib lint VISPER-Wireframe.podspec' to ensure this is a

Pod::Spec.new do |s|
  s.name             = 'VISPER-Wireframe'
  s.version          = '2.1.0'
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

  s.source_files = 'VISPER-Wireframe/Classes/**/*'

  s.dependency 'VISPER-Core','~> 2.1.0'
  s.dependency 'VISPER-Objc','~> 2.1.0'
  s.dependency 'VISPER-Presenter','~> 2.1.0'
  s.dependency 'VISPER-UIViewController','~> 2.1.0'

end
