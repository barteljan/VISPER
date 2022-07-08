Pod::Spec.new do |s|
  s.name             = 'VISPER-Sourcery'
  s.version          = '5.0.0'
  s.summary          = 'Sourcery templates for VISPER-Redux'
  s.description      = <<-DESC
Added some sourcery templates to VISPER Redux to generate AppReducers and States
                       DESC

  s.homepage         = 'https://github.com/barteljan/VISPER/blob/master/docs/README-VISPER-Sourcery.md'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jan Bartel' => 'barteljan@yahoo.de' }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-Sourcery-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/barteljan'

  s.ios.deployment_target = '13.0'
  s.swift_version = '4.2'
  
  s.source_files = 'VISPER-Sourcery/Classes/*.swift'
  
  s.resource_bundle = {
      'VISPER-Redux-Sourcery' => ['VISPER-Sourcery/Assets/*.stencil']
  }

  s.dependency 'VISPER-Swift','~> 5.0.0'

end
