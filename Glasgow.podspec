Pod::Spec.new do |s|
  s.name             = 'Glasgow'
  s.version          = '0.1.5'
  s.summary          = 'Foundation classes used to eliminate boiler-plate code and provide an accelerated startup time.'
  s.homepage         = 'https://github.com/inacioferrarini/glasgow'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Inácio Ferrarini' => 'inacio.ferrarini@gmail.com' }
  s.source           = { :git => 'https://github.com/inacioferrarini/glasgow.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  
  s.documentation_url = 'https://inacioferrarini.github.io/glasgow/#{s.version.to_s}'

  s.subspec "Core" do |core|
    core.source_files = "Glasgow/Classes/Core/**/*.swift"
  end

  s.subspec "UIKit" do |ui|
    ui.source_files = "Glasgow/Classes/UIKit/**/*.swift"
    ui.dependency 'Glasgow/Core'
  end

  s.subspec "Transformer" do |transformer|
    transformer.source_files = "Glasgow/Classes/Transformer/**/*.swift"
  end

  s.subspec "Networking" do |networking|
    networking.source_files = "Glasgow/Classes/Networking/**/*.swift"
    networking.dependency 'Glasgow/Transformer'
  end

  s.subspec "Arrow" do |arrow|
    arrow.source_files = "Glasgow/Classes/Arrow/**/*.swift"
    arrow.dependency 'Glasgow/Transformer'
    arrow.dependency 'Arrow' , '3.0.5'
  end

  s.subspec "CoreData" do |cd|
    cd.source_files = "Glasgow/Classes/CoreData/**/*.swift"
    cd.dependency 'Glasgow/Core'
  end

end
