# Be sure to run `pod lib lint VISPER-Redux.podspec' to ensure this is a
Pod::Spec.new do |s|
  s.name             = 'VISPER-Sourcery'
  s.version          = '0.3.0'
  s.summary          = 'Sourcery templates for VISPER-REdux'
  s.description      = <<-DESC
Added some sourcery templates to VISPER Redux to generate AppReducers and States
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER/blob/master/README-VISPER-Sourcery.md'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Sourcery-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/barteljan'

  s.ios.deployment_target = '8.0'
  
  s.source_files = 'VISPER-Sourcery/Classes/*.swift'
  
  s.resource_bundle = {
      'VISPER-Redux-Sourcery' => ['VISPER-Sourcery/Assets/*.stencil']
  }

  s.dependency 'VISPER-Swift','~> 2.1.0'

end
