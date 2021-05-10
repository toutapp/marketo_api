# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'marketo_api/version'

Gem::Specification.new do |spec|
  spec.authors       = ['Ami Bhatt', 'Mohnish Thallavajhula']
  spec.name          = 'marketo_api'
  spec.version       = MarketoApi::VERSION
  spec.summary       = spec.description = %q{Marketo REST API ruby gem}
  spec.homepage      = 'https://github.com/toutapp/marketo_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0'

  spec.add_dependency 'faraday_middleware', '~> 0.14.0'
  spec.add_dependency 'faraday', '~> 0.17.4'
  spec.add_dependency 'hashie', '~> 3.5.6'
  spec.add_dependency 'json', '>= 1.7.5'

  spec.add_development_dependency 'rake', '~> 12.0.0'
  spec.add_development_dependency 'rspec', '~> 3.6.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'rubocop', '~> 0.49.1'
  spec.add_development_dependency 'simplecov', '~> 0.14.1'
  spec.add_development_dependency 'webmock', '~> 1.13.0'
end
