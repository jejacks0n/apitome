module Apitome
  class Engine < ::Rails::Engine
    isolate_namespace Apitome

    initializer :assets, group: :all do |app|
      # default the root if it's not set
      Apitome.configuration.root ||= app.root
    end

    config.after_initialize do |app|
      # prepend routes so a catchall doesn't get in the way
      app.routes.prepend do
        mount Apitome::Engine => Apitome.configuration.mount_at
      end
    end

  end
end
