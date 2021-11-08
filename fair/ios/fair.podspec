#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fair.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fair'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # s.preserve_paths = 'FairDynamicFlutter/Products/FairDynamicFlutter.framework'
  s.vendored_frameworks = 'FairDynamicFlutter/Products/FairDynamicFlutter.framework'
  s.xcconfig = { 
    'OTHER_LDFLAGS' => '-ObjC'
  }
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64 arm64e armv7s' }
  s.requires_arc = true
  #指定Pod为静态库模式
  s.static_framework      = true

end
