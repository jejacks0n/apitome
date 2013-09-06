require "singleton"

module Apitome
  class Configuration
    include Singleton

    cattr_accessor :mount_at, :root, :doc_path, :title, :layout, :theme, :readme
    @@mount_at     = "/api/docs"
    @@root         = nil # will default to 'api/docs' if left unset
    @@doc_path     = 'doc/api'
    @@title        = 'Apitome Documentation'
    @@layout       = 'apitome/application'
    @@theme        = 'default'
    @@readme       = 'readme.md'

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
