# Be sure to run `pod lib lint VISPER-Redux.podspec' to ensure this is a
Pod::Spec.new do |s|
  s.name             = 'VISPER-Entity'
  s.version          = '0.2.0'
  s.summary          = 'VISPER-Entity is the implementation of the entity layer in VISPER'
  s.description      = <<-DESC
VISPER-Entity is the implementation of the entity layer in VISPER. (VISPER is a framework for building component based apps with the viper architecture in swift.)
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Entity-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/barteljan'

  s.ios.deployment_target = '8.0'
  
  s.dependency 'VISPER-Core','~> 2.0.0'
  s.dependency 'VISPER-Reactive','~> 2.0.0'
  s.source_files = 'VISPER-Entity/Classes/*.swift'

end
