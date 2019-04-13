module Apitome
  class Engine < ::Rails::Engine
    isolate_namespace Apitome
    apitome = Apitome.configuration

    routes do
      root to: "docs#index"
      get "/simulate/*path", to: "docs#simulate", as: :simulated if apitome.simulated_response
      get "/*path", to: "docs#show" unless Apitome.configuration.single_page
    end

    initializer :assets, group: :all do |app|
      apitome.root ||= app.root

      config.assets.precompile += ["apitome/*.css", "apitome/*.js"]
      config.assets.paths << root.join("assets", "stylesheets").to_s
      config.assets.paths << root.join("assets", "javascripts").to_s
    end

    config.after_initialize do |app|
      if apitome.mount_at.present?
        app.routes.prepend do
          mount Apitome::Engine => apitome.mount_at
        end
      end
    end
  end
end
