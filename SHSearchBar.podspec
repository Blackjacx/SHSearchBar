Pod::Spec.new do |s|
  s.name             = 'SHSearchBar'
  s.version          = '1.2.1'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'The search bar that does not suck.'
  s.description      = <<-DESC
The clean and shiny search bar that does what UISearchBar does only with dirty hacks. This search bar class is designed to overcome the customization limits of UISearchBar. The difference here is that this class does not inherit UISearchBar but composes a new UIView object by using a UITextField that is much easier to use.
                       DESC
  s.homepage         = 'https://github.com/Blackjacx/SHSearchBar'
  s.social_media_url = 'https://twitter.com/Blackjacxxx'
  s.author           = { 'Stefan Herold' => 'stefan.herold@gmail.com' }
  s.source           = { :git => 'https://github.com/Blackjacx/SHSearchBar.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*.swift'
end
