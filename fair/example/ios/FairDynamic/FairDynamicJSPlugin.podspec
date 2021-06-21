#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fair.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'FairDynamicJSPlugin'
  s.version          = '0.0.1'
  s.summary          = 'FairDynamicJSPlugin.'
  s.description      = <<-DESC
FairDynamicFlutter.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.platform = :ios, '8.0'
  s.dependency 'Flutter'

  s.subspec 'FairDynamicJSPlugin' do |ss|
    ss.source_files = 'FairDynamicFlutter/FairDynamicJSPlugin/**/*'
    ss.public_header_files = 'FairDynamicFlutter/FairDynamicJSPlugin/**/*.h'
  end

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }

  s.preserve_paths = 'FairDynamicFlutter/Products/FairDynamicFlutter.framework'
  s.vendored_frameworks = 'FairDynamicFlutter/Products/FairDynamicFlutter.framework'
  
end
