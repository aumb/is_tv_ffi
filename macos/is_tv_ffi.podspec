#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint is_tv_ffi.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'is_tv_ffi'
  s.version          = '0.7.0'
  s.summary          = 'Detects whether the current device is a TV.'
  s.description      = <<-DESC
The macOS side of the is_tv_ffi Flutter plugin. Exposes an `is_tv` C symbol
that always reports false, since macOS never presents a TV interface idiom.
                       DESC
  s.homepage         = 'https://github.com/aumb/is_tv_ffi'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mathiew Abbas' => 'mathiew95@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'

  s.resource_bundles = {'is_tv_ffi_privacy' => ['Resources/PrivacyInfo.xcprivacy']}

  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.15'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
