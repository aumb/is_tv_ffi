#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint is_tv_ffi.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'is_tv_ffi'
  s.version          = '0.7.0'
  s.summary          = 'Detects whether the current device is a TV.'
  s.description      = <<-DESC
The iOS/tvOS side of the is_tv_ffi Flutter plugin. Exposes an `is_tv` C symbol
that reports whether UIDevice's user interface idiom is `.tv`.
                       DESC
  s.homepage         = 'https://github.com/aumb/is_tv_ffi'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mathiew Abbas' => 'mathiew95@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.resource_bundles = {'is_tv_ffi_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
