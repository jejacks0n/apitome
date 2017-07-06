require "codeclimate-test-reporter"

# require "simplecov"
# SimpleCov.start

ENV["RAILS_ENV"] ||= "test"
ENV["RAILS_ROOT"] = File.expand_path("../dummy", __FILE__)
require File.expand_path("../dummy/config/environment", __FILE__)

require "apitome"

require "rspec/rails"
require "capybara/rails"
require "aruba/api"

require "fileutils"
require "ostruct"

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.order = "random"
  config.include Rack::Test::Methods
  config.include Aruba::Api

  config.before(:each, shell: true) do
    @aruba_timeout_seconds = 180
    clean_current_dir
  end

  config.after(:each, shell: true) do
    restore_env
    clean_current_dir
  end

  config.before(:each, browser: true) do
    Capybara.current_driver = Capybara.javascript_driver
  end
end
