# Be sure to run `pod lib lint VISPER-Redux.podspec' to ensure this is a
Pod::Spec.new do |s|
  s.name             = 'VISPER-Redux'
  s.version          = '3.0.0'
  s.summary          = 'VISPER-Redux is an implementation of the redux-architecture in swift.'
  s.description      = <<-DESC
VISPER-Redux is an implementation of the redux-architecture in swift. It's a core function of the VISPER Application Framework for iOS-Apps. (VISPER is a framework for building component based apps with the viper architecture in swift.)
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER/master/README-VISPER-Redux.md'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Redux-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/barteljan'

  s.ios.deployment_target = '8.0'
  
  s.dependency 'VISPER-Core','~> 3.0.0'
  s.dependency 'VISPER-Reactive','~> 3.0.0'
  s.source_files = 'VISPER-Redux/Classes/*.swift'

end
