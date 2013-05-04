version = "1.12.0.3"
version_tag = "#{version}-OpenTable"

Pod::Spec.new do |s|
# basic meta data
  s.name          = 'MoPubSDK-OpenTable'
  s.version       = version
  s.platform      = :ios, "5.0"
  s.author        = { 'MoPub' => 'contact@mopub.com' }
  s.license       = { :type => 'New BSD', :file => 'LICENSE'}
  s.homepage      = 'http://github.com/mopub/mopub-client'
  s.summary       = <<-DESC
Pod for MoPub iOS library.
                    DESC
  s.description   = <<-DESC
Straight port to CocoaPod for MoPub library.
                    DESC
  s.source        = { :git => 'https://github.com/opentable/mopub-ios-sdk.git', :tag => version_tag }

# only include source files from the proper SDK, not sample App
  s.source_files  = ["MoPubSDK/**/*.{h,m}"]
  
# don't forget bundle and such
  s.resources = ['MoPubSDK/Resources/*', 'MoPubSDK/**/*.xib']
  
  s.header_dir = 'MoPubSDK'

# the project is now arcified
  s.requires_arc = true

# pull in TouchJSON since it's needed
  s.dependency    'TouchJSON', '>= 1.0'
end