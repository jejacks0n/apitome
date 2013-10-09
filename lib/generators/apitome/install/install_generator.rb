module Apitome
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../", __FILE__)

      desc "Installs the Apitome initializer and markdown file into your application."

      def copy_initializers
        copy_file "templates/initializer.rb", "config/initializers/apitome.rb"
        copy_file "templates/api.md", "doc/api.md"
      end

      def display_readme
        readme "POST_INSTALL" if behavior == :invoke
      end

    end
  end
end
