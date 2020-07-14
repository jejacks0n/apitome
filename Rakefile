begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

# setup the dummy app
APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load "rails/tasks/engine.rake"

# useful bundler gem tasks
require "bundler/gem_tasks"

# load in rspec tasks
load "rspec/rails/tasks/rspec.rake"

# apitome build tasks
namespace :apitome do
  desc "Combine and bundle javascripts and stylesheets"
  task build: ["build:javascripts", "build:stylesheets"]

  task javascripts: :environment do
    env = Rails.application.assets
    root = Apitome::Engine.root.join("app/assets")

    puts "Building javascripts..."

    asset = env.find_asset("apitome/application.js")
    asset.write_to(root.join("javascripts/apitome", "bundle.js"))
  end

  task stylesheets: :environment do
    env = Rails.application.assets
    root = Apitome::Engine.root.join("app/assets")

    puts "Building stylesheets..."

    asset = env.find_asset("apitome/application.css")
    asset.write_to(root.join("stylesheets/apitome", "bundle.css"))
  end
end

# setup the default task
Rake::Task["default"].prerequisites.clear
Rake::Task["default"].clear
task default: [:spec]
