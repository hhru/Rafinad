Pod::Spec.new do |spec|
  spec.name = "Rafinad"
  spec.version = "1.0.0"
  spec.summary = "A Swift DSL for UI testing of iOS, macOS and tvOS apps, featuring a simplified, chainable and compile-time safe syntax"

  spec.homepage = "https://github.com/hhru/Rafinad"
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { "Almaz Ibragimov" => "almazrafi@gmail.com" }
  spec.source = { :git => "https://github.com/hhru/Rafinad.git", :tag => "#{spec.version}" }

  spec.swift_version = '5.9'
  spec.requires_arc = true

  spec.ios.deployment_target = "15.0"
  spec.tvos.deployment_target = "15.0"

  spec.default_subspecs = 'Accessibility', 'Testing'

  spec.subspec 'Accessibility' do |subspec|
    subspec.source_files = 'Sources/Accessibility/**/*.swift'
    subspec.ios.frameworks = 'Foundation', 'SwiftUI', 'UIKit'
    subspec.tvos.frameworks = 'Foundation', 'SwiftUI', 'UIKit'
  end

  spec.subspec 'Testing' do |subspec|
    subspec.source_files = 'Sources/Testing/**/*.swift'
    subspec.frameworks = 'Foundation', 'XCTest'
    subspec.weak_frameworks = 'XCTest'
    subspec.dependency 'Rafinad/Accessibility'
  end
end
