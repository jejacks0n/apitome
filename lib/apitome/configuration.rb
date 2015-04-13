module Apitome
  class Configuration
    cattr_accessor *[
      :mount_at,
      :root,
      :doc_path,
      :title,
      :layout,
      :code_theme,
      :css_override,
      :js_override,
      :readme,
      :single_page,
      :url_formatter
    ]

    @@mount_at     = "/api/docs"
    @@root         = nil # will default to Rails.root if left unset
    @@doc_path     = "doc/api"
    @@title        = "Apitome Documentation"
    @@layout       = "apitome/application"
    @@code_theme   = "default"
    @@css_override = nil
    @@js_override  = nil
    @@readme       = "../api.md"
    @@single_page  = true
    @@url_formatter = -> (str) { str.gsub(/\.json$/, '').underscore.gsub(/[^0-9a-z]+/i, '-') }

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
