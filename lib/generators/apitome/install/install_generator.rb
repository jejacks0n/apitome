module Apitome
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../", __FILE__)

      desc "Installs the Apitome initializer and markdown file into your application."

      class_option :assets, type: :boolean, default: false,
        aliases: "-a", desc: "Install the javascript and stylesheet assets to /public"

      def copy_initializers
        copy_file "templates/initializer.rb", "config/initializers/apitome.rb"
        copy_file "templates/api.md", "doc/api.md"
      end

      def copy_assets
        return unless options[:assets]
        @asset_root = "../../../../app/assets"

        copy_file "#{@asset_root}/javascripts/apitome/bundle.js", "public/javascripts/apitome/application.js"
        copy_file "#{@asset_root}/stylesheets/apitome/bundle.css", "public/stylesheets/apitome/application.css"
      end

      def display_post_install
        readme "POST_INSTALL" if behavior == :invoke
      end
    end
  end
end
