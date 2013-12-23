#!/usr/bin/env rake
require "fileutils"

begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

# Dummy App
# -----------------------------------------------------------------------------
APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load "rails/tasks/engine.rake"
Bundler::GemHelper.install_tasks

# Assets
# -----------------------------------------------------------------------------
desc "Builds assets into the distribution ready bundle"
task :assets => ['assets:javascripts', 'assets:stylesheets'] do
  puts 'Done building'
end

namespace :assets do
  env  = Rails.application.assets
  root = Apitome::Engine.root.join('app/assets')

  task :build

  desc "Combine and bundle javascripts"
  task :javascripts => :environment do
    puts 'Building javascripts...'

    asset = env.find_asset('apitome/application.js')
    asset.write_to(root.join('javascripts/apitome', 'bundle.js'))
  end

  task :stylesheets => :environment do
    puts 'Building stylesheets...'

    asset = env.find_asset('apitome/application.css')
    asset.write_to(root.join('stylesheets/apitome', 'bundle.css'))
  end

end

# RSpec
# -----------------------------------------------------------------------------
#load "rspec/rails/tasks/rspec.rake"
#namespace :spec do
#  desc "Run the code examples in spec/features"
#  RSpec::Core::RakeTask.new("features") do |t|
#    t.pattern = "./spec/features/**/*_spec.rb"
#  end
#end

# Apitome
# -----------------------------------------------------------------------------

# Default
# -----------------------------------------------------------------------------
#Rake::Task["default"].prerequisites.clear
#Rake::Task["default"].clear
#
#task :default => [:spec, :teaspoon]
