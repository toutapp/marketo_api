require File.expand_path('../lib/marketo_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Ami Bhatt']
  gem.name          = 'marketo-api'
  gem.version       = MarketoApi::VERSION
  gem.summary       = gem.description = %q{Ruby REST API wrapper for Marketo}
  gem.homepage      = 'https://github.com/toutapp/marketo'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.0'

  gem.add_dependency 'faraday_middleware', '~> 0.11.0.1'
  gem.add_dependency 'faraday', '~> 0.12.2'
  gem.add_dependency 'hashie', '~> 3.5.6'
  gem.add_dependency 'json', '>= 1.7.5'

  gem.add_development_dependency 'rake', '~> 12.0.0'
  gem.add_development_dependency 'rspec', '~> 3.6.0'
  gem.add_development_dependency 'rubocop', '~> 0.49.1'
  gem.add_development_dependency 'simplecov', '~> 0.14.1'
  gem.add_development_dependency 'webmock', '~> 1.13.0'
end
