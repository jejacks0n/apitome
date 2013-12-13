# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'apitome/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'apitome'
  s.version     = Apitome::VERSION
  s.authors     = ['jejacks0n']
  s.email       = ['info@modeset.com']
  s.homepage    = 'https://github.com/modeset/apitome'
  s.summary     = 'Apitome: /iˈpitəmē/ An API documentation reader RSpec API Documentation'
  s.description = 'API documentation renderer for Rails using RSpec API Documentation JSON output'

  s.files       = Dir['{app,config,lib,vendor}/**/*'] + ['MIT.LICENSE', 'README.md']
  s.test_files  = Dir['{spec}/**/*']

  s.add_dependency 'railties', ['>= 3.2.5', '< 5']
  s.add_dependency 'rspec_api_documentation'
  s.add_dependency 'github-markdown'
end
