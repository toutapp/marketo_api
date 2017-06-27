require File.expand_path('../lib/marketo/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Ami Bhatt']
  gem.name          = 'marketo'
  gem.version       = Marketo::VERSION
  gem.summary       = %q{Ruby REST API wrapper for Marketo}
  gem.description   = %q{Ruby REST API wrapper for Marketo}
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  # gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 2.0'

  gem.add_dependency 'faraday', ['>= 0.9.0', '<= 1.0']
  gem.add_dependency 'faraday_middleware', ['>= 0.8.8', '<= 1.0']

  gem.add_dependency 'json', '>= 1.7.5'

  gem.add_dependency 'hashie', ['>= 1.2.0', '< 4.0']
end
