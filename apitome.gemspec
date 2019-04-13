# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "apitome/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "apitome"
  s.version     = Apitome::VERSION
  s.authors     = ["jejacks0n"]
  s.email       = ["jejacks0n@gmail.com"]
  s.homepage    = "https://github.com/jejacks0n/apitome"
  s.summary     = "Apitome: /iˈpitəmē/ An API documentation reader RSpec API Documentation"
  s.description = "API documentation renderer for Rails using RSpec API Documentation JSON output"
  s.license     = "MIT"
  s.files       = Dir["{app,config,lib,vendor}/**/*"] + ["MIT.LICENSE", "README.md"]

  s.required_ruby_version = "~> 2.4"

  s.add_dependency "railties"
  s.add_dependency "kramdown" # TODO: is this required?
  s.add_development_dependency "rspec_api_documentation"
end
