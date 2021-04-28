
Pod::Spec.new do |s|
  s.name             = 'NNPopoverButton'
  s.version          = '2.0.1'
  s.summary          = 'iOS 原生 Popover 封装'
  s.description      = '极简封装 PopoverButton'

  s.homepage         = 'https://github.com/shang1219178163/NNPopoverButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shang1219178163' => 'shang1219178163@gmail.com' }
  s.source           = { :git => 'https://github.com/shang1219178163/NNPopoverButton.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = "5.0"
  s.requires_arc = true

  s.source_files = 'NNPopoverButton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NNPopoverButton' => ['NNPopoverButton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'CoreFoundation', 'CoreText', 'CoreGraphics', 'CoreImage',
  #    'CoreLocation','CoreTelephony', 'GLKit','QuartzCore', 'WebKit'
  
  # s.dependency 'AFNetworking', '~> 2.3'
end
