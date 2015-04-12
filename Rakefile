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
begin
  Bundler::GemHelper.install_tasks
rescue RuntimeError
  Bundler::GemHelper.install_tasks name: "teaspoon"
end
# CODECLIMATE_REPO_TOKEN=5b15ecf8b9008ee8c4718712fd7b27f2fe9e7a758605ac86b56e04925c5cb511

# RSpec
# -----------------------------------------------------------------------------
load "rspec/rails/tasks/rspec.rake"

namespace :spec do
  desc "Run the unit code examples"
  RSpec::Core::RakeTask.new(:unit) do |t|
    file_list = FileList["spec/**/*_spec.rb"]
    %w(features).each do |exclude|
      file_list = file_list.exclude("spec/#{exclude}/**/*_spec.rb")
    end
    t.pattern = file_list
  end

  desc "Run the code examples in teaspoon-jasmine/spec"
  RSpec::Core::RakeTask.new(:jasmine) do |t|
    t.pattern = "../teaspoon-jasmine/spec/**/*_spec.rb"
  end

  desc "Run the code examples in teaspoon-mocha/spec"
  RSpec::Core::RakeTask.new(:mocha) do |t|
    t.pattern = "../teaspoon-mocha/spec/**/*_spec.rb"
  end

  desc "Run the code examples in teaspoon-qunit/spec"
  RSpec::Core::RakeTask.new(:qunit) do |t|
    t.pattern = "../teaspoon-qunit/spec/**/*_spec.rb"
  end
end

# Apitome
# -----------------------------------------------------------------------------
namespace :apitome do
  task build: ["build:javascripts", "build:stylesheets"]

  desc "Combine and bundle javascripts"
  task javascripts: :environment do
    env  = Rails.application.assets
    root = Apitome::Engine.root.join("app/assets")

    puts "Building javascripts..."

    asset = env.find_asset("apitome/application.js")
    asset.write_to(root.join("javascripts/apitome", "bundle.js"))
  end

  task stylesheets: :environment do
    env  = Rails.application.assets
    root = Apitome::Engine.root.join("app/assets")

    puts "Building stylesheets..."

    asset = env.find_asset("apitome/application.css")
    asset.write_to(root.join("stylesheets/apitome", "bundle.css"))
  end
end

# Default
# -----------------------------------------------------------------------------
Rake::Task["default"].prerequisites.clear
Rake::Task["default"].clear

task default: [:spec]
