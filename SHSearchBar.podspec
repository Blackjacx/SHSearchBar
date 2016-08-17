#
# Be sure to run `pod lib lint SHSearchBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SHSearchBar'
  s.version          = '0.9.2'
  s.summary          = 'The search bar that does not suck.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The clean and shiny search bar that does what UISearchBar does only with dirty hacks. This search bar class is designed to overcome the customization limits of UISearchBar. The difference here is that this class does not inherit UISearchBar but composes a new UIView object by using a UITextField that is much easier to use.
                       DESC

  s.homepage         = 'https://github.com/Blackjacx/SHSearchBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Stefan Herold' => 'stefan.herold@gmail.com' }
  s.source           = { :git => 'https://github.com/Blackjacx/SHSearchBar.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Blackjacxxx'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SHSearchBar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SHSearchBar' => ['SHSearchBar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
