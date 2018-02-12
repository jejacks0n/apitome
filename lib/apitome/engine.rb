module Apitome
  class Engine < ::Rails::Engine
    isolate_namespace Apitome

    if Apitome.configuration.precompile_assets && config.respond_to?(:assets)
      config.assets.precompile += %w{apitome/*.css apitome/*.js}
    end

    config.assets.paths << root.join('assets', 'stylesheets').to_s
    config.assets.paths << root.join('assets', 'javascripts').to_s

    initializer :assets, group: :all do |app|
      # default the root if it's not set
      Apitome.configuration.root ||= app.root
    end

    config.after_initialize do |app|
      # prepend routes so a catchall doesn't get in the way
      if Apitome.configuration.mount_at.present?
        app.routes.prepend do
          mount Apitome::Engine => Apitome.configuration.mount_at
        end
      end
    end
  end
end
