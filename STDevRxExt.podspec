Pod::Spec.new do |s|
  s.name             = 'STDevRxExt'
  s.version          = '0.2.0'
  s.summary          = 'STDevRxExt contains some extension functions for RxSwift and RxCoca which makes our live easy.'
  s.swift_version = '5.0'

  s.description      = <<-DESC
STDevRxExt contains following 3 type of extensions for RxSwift and RxCocoa:
* Filter Extensions
* Map Extensions
* Cast Extensions
* more coming soon
                       DESC

  s.homepage         = 'https://github.com/STDevTM/STDevRxExt'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tigran Hambardzumyan' => 'tigran@stdevmail.com' }
  s.source           = { :git => 'https://github.com/STDevTM/STDevRxExt.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'STDevRxExt/Classes/**/*'

  s.dependency 'RxSwift', '~> 5.1'
  s.dependency 'RxCocoa', '~> 5.1'
end
