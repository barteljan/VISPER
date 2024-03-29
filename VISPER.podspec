Pod::Spec.new do |s|
  s.name             = "VISPER"
  s.version          = '5.0.0'
  s.summary          = "A library to support building component based apps with the VIPER architecture."
  s.description      = <<-DESC
                       A iOS library to support building component based apps with the VIPER architecture

                       Contains some base classes to design VIPER based iOS-Apps.
                       The framework includes a basic class for viewcontrollers, presenters, a redux implementation for the interactor layer, a wireframe, etc ...
DESC
  s.homepage         = "https://github.com/barteljan/VISPER"
  s.license          = 'MIT'
  s.author           = { "Jan Bartel" => "barteljan@yahoo.de" }
  s.source           = { :git => 'https://github.com/barteljan/VISPER.git', :tag => 'VISPER-'+String(s.version) }
  s.social_media_url = 'https://twitter.com/janbartel'

  s.platform     = :ios, '13.0'
  s.swift_version = '4.2'
  s.requires_arc = true

  s.frameworks = 'UIKit'
  s.dependency 'VISPER-Core','~> 5.0.0'
  s.dependency 'VISPER-Objc','~> 5.0.0'
  s.dependency 'VISPER-Swift','~> 5.0.0'
  s.dependency 'VISPER-Presenter','~> 5.0.0'
  s.dependency 'VISPER-Wireframe','~> 5.0.0'
  s.dependency 'VISPER-Entity','~> 5.0.0'

  s.default_subspec = 'Standard'

  s.subspec 'Standard' do |standard|
     standard.source_files = 'VISPER/Classes/Bridge/**/*','VISPER/Classes/Deprecated/**/*'
     standard.public_header_files = 'VISPER/Classes/**/*.h'
     standard.dependency 'VISPER-CommandBus'
  end

  s.subspec 'NoDeprecated' do |standard|
     standard.source_files = 'VISPER/Classes/Bridge/**/*'
  end

end
