#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
#
Pod::Spec.new do |s|
  s.name             = 'app_blocker'
  s.version          = '2.2.0'
  s.summary          = 'Cross-platform app blocking plugin for Flutter.'
  s.description      = <<-DESC
Cross-platform app blocking plugin for Flutter. Block apps with a custom block screen (Android)
and Screen Time Shield (iOS). Supports scheduling, focus profiles, and events.
                       DESC
  s.homepage         = 'https://github.com/kaneiof/app_blocker'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'KhanhTQ' => 'khanhtq@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '16.0'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  }
  s.swift_version = '5.0'
end
