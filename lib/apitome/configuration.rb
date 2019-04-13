require "singleton"

module Apitome
  class Configuration
    include Singleton

    cattr_accessor *[
      :mount_at,
      :root,
      :doc_path,
      :parent_controller,
      :title,
      :layout,
      :code_theme,
      :css_override,
      :js_override,
      :readme,
      :single_page,
      :url_formatter,
      :remote_url,
      :http_basic_authentication,
      :precompile_assets,
      :simulated_response,
    ]

    @@mount_at = "/api/docs"
    @@root = nil # will default to Rails.root if left unset
    @@doc_path = "doc/api"
    @@parent_controller = "ActionController::Base"
    @@title = "Apitome Documentation"
    @@layout = "apitome/application"
    @@code_theme = "default"
    @@css_override = nil
    @@js_override = nil
    @@readme = "../api.md"
    @@single_page = true
    @@url_formatter = -> (str) { str.gsub(/\.json$/, "").underscore.gsub(/[^0-9a-z]+/i, "-") }
    @@remote_url = nil
    @@http_basic_authentication = nil
    @@precompile_assets = true
    @@simulated_response = true

    def self.root=(path)
      @@root = Pathname.new(path.to_s) if path.present?
    end
  end

  mattr_accessor :configuration
  @@configuration = Configuration

  def self.configure
    yield @@configuration
  end
  singleton_class.send(:alias_method, :setup, :configure)
end
