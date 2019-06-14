
Pod::Spec.new do |s|
s.name             = 'LXAdapter'
s.version          = '1.0.0'
s.summary          = 'LXAdapter'
s.description      = <<-DESC
测试
DESC    

s.homepage         = 'http://www.adbana.com'
s.license          = { :type => 'MIT', :text => ''}
s.author           = 'AdBana Inc.' 
s.source           = { :git => 'https://github.com/yushengr/LXAdapter', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.subspec 'GDT' do |ss|
    ss.dependency 'AdBanaGDTMobSDK'
    
    ss.subspec 'Bana' do |sss|
        sss.source_files = 'LXAdapter/GDT/Bana/Classes/*.{h,m}'
        sss.dependency 'AdBanaSDK/Bana'
    end
    
end

 

end
