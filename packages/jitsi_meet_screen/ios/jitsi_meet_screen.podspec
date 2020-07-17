#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint jitsi_meet_screen.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'jitsi_meet_screen'
  s.version          = '0.0.1'
  s.summary          = 'Plugin to show JitsiMeetView as new native screen'
  s.description      = <<-DESC
Plugin to show JitsiMeetView as new native screen
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
    s.dependency 'JitsiMeetSDK'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
