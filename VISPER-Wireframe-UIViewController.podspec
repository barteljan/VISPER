#
# Be sure to run `pod lib lint VISPER-Wireframe.podspec' to ensure this is a

Pod::Spec.new do |s|
  s.name             = 'VISPER-Wireframe-UIViewController'
  s.version          = '0.1.0'
  s.summary          = 'A short description of VISPER-Wireframe.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER-Wireframe'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'barteljan' => 'jan.bartel@atino.net' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER-Wireframe.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.ios.deployment_target = '8.0'

  s.source_files = 'VISPER-Wireframe-UIViewController/Classes/**/*'
  s.dependency 'VISPER-Wireframe-Objc'
end
