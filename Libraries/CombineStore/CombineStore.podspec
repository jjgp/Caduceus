Pod::Spec.new do |spec|
    spec.author                = 'Jason Prasad'
    spec.homepage              = 'https://github.com/jjgp/Caduceus'
    spec.ios.deployment_target = '13.0'
    spec.license               = { :type => 'MIT' }
    spec.name                  = 'CombineStore'
    spec.source                = { :git => 'https://github.com/jjgp/Caduceus', :branch => 'master' } 
    spec.source_files          = 'Sources/**/*.swift'
    spec.summary               = 'CombineStore'
    spec.swift_version         = '5.2'
    spec.version               = '1.0.0'
end
