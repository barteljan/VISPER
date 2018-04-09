# Be sure to run `pod lib lint VISPER-Redux.podspec' to ensure this is a
Pod::Spec.new do |s|
  s.name             = 'VISPER-Reactive'
  s.version          = '2.0.1'
  s.summary          = 'Simple implementation of observable properties used in the VISPER Framework'
  s.description      = <<-DESC
Base implementation of reactive properties for the VISPER Framework.
(VISPER is a framework for building component based apps with the viper architecture in swift.)
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Reactive-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/barteljan'

  s.ios.deployment_target = '8.0'

  s.default_subspec = 'Standard'

  s.subspec 'Standard' do |standard|
    standard.source_files = 'VISPER-Reactive/Classes/Core/*.swift'
  end

  s.subspec 'RxSwift' do |rxswift|
    rxswift.source_files = 'VISPER-Reactive/Classes/RxSwift/*.swift','VISPER-Reactive/Classes/Core/*.swift'
    rxswift.dependency 'RxSwift', '~> 4.0'
  end

end

