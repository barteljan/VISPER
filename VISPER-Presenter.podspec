#
# Be sure to run `pod lib lint SwiftyVISPER.podspec' to ensure this is a
# valid spec before submitting.
Pod::Spec.new do |s|
  s.name             = 'VISPER-Presenter'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SwiftyVISPER.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/barteljan/SwiftyVISPER'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/SwiftyVISPER.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.ios.deployment_target = '8.0'
  s.source_files = 'VISPER-Presenter/Classes/**/*'
  s.dependency 'VISPER-Core'
end