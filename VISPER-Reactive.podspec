# Be sure to run `pod lib lint VISPER-Redux.podspec' to ensure this is a
Pod::Spec.new do |s|
  s.name             = 'VISPER-Reactive'
  s.version          = '0.1.2'
  s.summary          = 'VISPER-Redux is an implementation of the redux-architecture in swift.'
  s.description      = <<-DESC
VISPER-Redux is an implementation of the redux-architecture in swift. It's a core function of the VISPER Application Framework for iOS-Apps
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER-Redux'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER-Redux.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/barteljan'

  s.ios.deployment_target = '8.0'

  s.default_subspec = 'Standard'
  s.dependency 'VISPER-Core'

  s.subspec 'Standard' do |standard|
    standard.source_files = 'VISPER-Reactive/Classes/Standard/*.swift','VISPER-Reactive/Classes/Core/*.swift'
  end

  s.subspec 'RxSwift' do |rxswift|
    rxswift.source_files = 'VISPER-Reactive/Classes/RxSwift/*.swift','VISPER-Reactive/Classes/Core/*.swift','VISPER-Reactive/Classes/Standard/*.swift'
    rxswift.dependency 'RxSwift', '~> 4.0'
  end

end

