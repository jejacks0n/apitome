module Apitome
  class Configuration
    cattr_accessor *[
      :mount_at,
      :root,
      :doc_path,
      :parent_controller,
      :logo_url,
      :title,
      :layout,
      :code_theme,
      :css_override,
      :js_override,
      :favicon_url,
      :readme,
      :single_page,
      :remote_docs,
      :remote_url,
      :url_formatter,
      :precompile_assets
    ]

    @@mount_at          = "/api/docs"
    @@root              = nil # will default to Rails.root if left unset
    @@doc_path          = "doc/api"
    @@parent_controller = "ActionController::Base"
    @@logo_url          = nil
    @@title             = "Apitome Documentation"
    @@layout            = "apitome/application"
    @@code_theme        = "default"
    @@css_override      = nil
    @@js_override       = nil
    @@favicon_url       = nil
    @@readme            = "../api.md"
    @@single_page       = true
    @@remote_docs       = false
    @@remote_url        = nil
    @@url_formatter     = -> (str) { str.gsub(/\.json$/, '').underscore.gsub(/[^0-9a-z]+/i, '-') }
    @@precompile_assets = true

    def self.root=(path)
      @@root = Pathname.new(path.to_s) if path.present?
    end

    def self.code_theme_url
      "apitome/highlight_themes/#{@@code_theme}"
    end
  end

  mattr_accessor :configuration
  @@configuration = Configuration

  def self.setup
    yield @@configuration
  end
end
