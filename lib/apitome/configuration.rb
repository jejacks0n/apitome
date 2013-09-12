require "singleton"

module Apitome
  class Configuration
    include Singleton

    cattr_accessor :mount_at, :root, :doc_path, :title, :layout, :main_theme, :code_theme, :css_override, :js_override, :readme, :single_page
    @@mount_at     = "/api/docs"
    @@root         = nil # will default to 'api/docs' if left unset
    @@doc_path     = 'doc/api'
    @@title        = 'Apitome Documentation'
    @@layout       = 'apitome/application'
    @@main_theme   = 'default'
    @@code_theme   = 'default'
    @@css_override = nil
    @@js_override  = nil
    @@readme       = '../readme.md'
    @@single_page  = false

    def self.root=(path)
      @@root = Pathname.new(path.to_s) if path.present?
    end
  end

  mattr_accessor :configuration
  @@configuration = Configuration

  def self.setup
    yield @@configuration
  end
end
