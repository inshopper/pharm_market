lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pharm_market/version'

Gem::Specification.new do |spec|
  spec.name          = 'pharm_market'
  spec.version       = PharmMarket::VERSION
  spec.authors       = ['Ivan Novikov']
  spec.email         = ['ivan.novikov@corp.mail.ru']

  spec.summary       = 'Client for pharm market api'
  spec.homepage      = 'https://github.com/inshopper/pharm_market'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = ['>= 2.4.0', '< 2.6.0']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.61.1'

  spec.add_runtime_dependency 'activesupport', '~> 5.0'
  spec.add_runtime_dependency 'faraday', '>= 0.12.2'
  spec.add_runtime_dependency 'faraday-encoding', '>= 0.0.4'
  spec.add_runtime_dependency 'faraday_middleware'
end
