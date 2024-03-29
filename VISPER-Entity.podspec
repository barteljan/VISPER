Pod::Spec.new do |s|
  s.name             = 'VISPER-Entity'
  s.version          = '5.0.0'
  s.summary          = 'VISPER-Entity is the implementation of the entity layer in VISPER'
  s.description      = <<-DESC
VISPER-Entity is the implementation of the entity layer in VISPER. (VISPER is a framework for building component based apps with the viper architecture in swift.)
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Entity-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/barteljan'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  
  s.source_files = 'VISPER-Entity/Classes/*.swift'
  
end
