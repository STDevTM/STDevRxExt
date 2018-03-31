Pod::Spec.new do |s|
  s.name             = 'STDevRxExt'
  s.version          = '0.1.0'
  s.summary          = 'STDevRxExt contains some extension functions for RxSwift and RxCoca which makes our live easy.'

  s.description      = <<-DESC
STDevRxExt contains following 3 type of extensions for RxSwift and RxCocoa:
* Filter Extensions
* Map Extensions
* Cast Extensions
* more coming soon
                       DESC

  s.homepage         = 'https://github.com/stdevteam/STDevRxExt'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tigran Hambardzumyan' => 'tigran@stdevmail.com' }
  s.source           = { :git => 'https://github.com/stdevteam/STDevRxExt.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

  s.source_files = 'STDevRxExt/Classes/**/*'

  s.dependency 'RxSwift', '~> 4.1.2'
  s.dependency 'RxCocoa', '~> 4.1.2'
end
