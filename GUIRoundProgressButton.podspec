Pod::Spec.new do |s|

  s.name          = "GUIRoundProgressButton"
  s.version       = "0.0.2"
  s.summary       = "GUIRoundProgressButton is a good looking, round button with a progress indicator."
  s.homepage      = "https://github.com/guilhermearaujo/GUIRoundProgressButton"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Guilherme Araújo" => "guilhermeama@gmail.com" }
  s.platform      = :ios, "8.0"
  s.source        = { :git => "https://github.com/guilhermearaujo/GUIRoundProgressButton.git", :tag => "0.0.2" }
  s.source_files  = "GUIRoundProgressButton/Classes", "GUIRoundProgressButton/Classes/**/*.{h,m}"
  s.requires_arc  = true

end
