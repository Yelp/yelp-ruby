# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yelp/version'

Gem::Specification.new do |spec|
  spec.name          = 'yelp'
  spec.version       = Yelp::VERSION
  spec.authors       = ['Tomer Elmalem', 'Justin Cunningham', 'Yelp']
  spec.email         = ['telmalem@gmail.com', 'partnerships@yelp.com']
  spec.summary       = %q{Ruby client library for the Yelp API}
  spec.description   = 'Provides an easy way to interact with the Yelp API in any kind of application'
  spec.homepage      = 'https://github.com/Yelp/yelp-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.0', '>= 10.0.0'
  spec.add_development_dependency 'rspec', '~> 2.6'
  spec.add_development_dependency 'rspec-its', '~> 1.0.1'
  spec.add_development_dependency 'pry', '~> 0.9', '>= 0.9.0'
  spec.add_development_dependency 'vcr', '~> 2.8', '>= 2.8.0'
  spec.add_development_dependency 'webmock', '~> 1.17', '>= 1.17.0'
  spec.add_development_dependency 'yard', '~> 0.9.11'

  spec.add_runtime_dependency 'faraday', '<= 1.0.0'
  spec.add_runtime_dependency 'faraday_middleware'
  spec.add_runtime_dependency 'simple_oauth', '~> 0.3.1'
end
