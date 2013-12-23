module Apitome
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../", __FILE__)

      desc "Installs the Apitome initializer and markdown file into your application."

      class_option :assets, type: :boolean,
                   aliases: "-a",
                   default: false,
                   desc:    "Install the javascript and stylesheet assets to /public"

      def copy_initializers
        copy_file "templates/initializer.rb", "config/initializers/apitome.rb"
        copy_file "templates/api.md", "doc/api.md"
      end

      def copy_assets
        return unless options[:assets]
        copy_file "../../../../app/assets/javascripts/apitome/bundle.js", "public/assets/apitome/application.js"
        copy_file "../../../../app/assets/stylesheets/apitome/bundle.css", "public/assets/apitome/application.css"
      end

      def display_readme
        readme "POST_INSTALL" if behavior == :invoke
      end

    end
  end
end
