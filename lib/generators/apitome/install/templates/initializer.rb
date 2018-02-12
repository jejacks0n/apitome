Apitome.setup do |config|
  # This determines where the Apitome routes will be mounted. Changing this to '/api/documentation' for instance would
  # allow you to browse to http://localhost:3000/api/documentation to see your api documentation. Set to nil and mount
  # it yourself if you need to.
  config.mount_at = "/api/docs"

  # This defaults to Rails.root if left nil. If you're providing documentation for an engine using a dummy application
  # it can be useful to set this to your engines root.. E.g. Application::Engine.root
  config.root = nil

  # This is where rspec_api_documentation outputs the JSON files. This is configurable within RAD, and so is
  # configurable here.
  config.doc_path = "doc/api"

  # Set a parent controller that Apitome::DocsController inherits from. Useful if you want to use a custom
  # `before_action`.
  config.parent_controller = "ActionController::Base"

  # The title of the documentation -- If your project has a name, you'll want to put it here.
  config.title = "Apitome Documentation"

  # The main layout view for all documentation pages. By default this is pretty basic, but you may want to use your own
  # application layout.
  config.layout = "apitome/application"

  # We're using highlight.js (https://github.com/isagalaev/highlight.js) for code highlighting, and it comes with some
  # great themes. You can check http://softwaremaniacs.org/media/soft/highlight/test.html for themes, and enter the
  # theme as lowercase/underscore.
  config.code_theme = "default"

  # This allows you to override the css manually. You typically want to require `apitome/application` within the
  # override, but if you want to override it entirely you can do so.
  config.css_override = nil

  # This allows you to override the javascript manually. You typically want to require `apitome/application` within the
  # override, but if you want to override it entirely you can do so.
  config.js_override = nil

  # You can provide a 'README' style markdown file for the documentation, which is a useful place to include general
  # information. This path is relative to your doc_path configuration.
  config.readme = "../api.md"

  # Apitome can render the documentation into a single page that uses scrollspy, or it can render the documentation on
  # individual pages on demand. This allows you to specify which one you want, as a single page may impact performance.
  config.single_page = true

  # You can specify how urls are formatted using a Proc or other callable object.
  # Your proc will be called with a resource name or link, giving you the opportunity to modify it as necessary for in the documentation url.
  config.url_formatter = -> (str) { str.gsub(/\.json$/, '').underscore.gsub(/[^0-9a-z\:]+/i, '-') }

  # You can setup the docs to be loaded from a remote URL if they are
  # not available in the application environment. This defaults to
  # false.
  config.remote_docs = false

  # If the remote_docs is set to true, this URL is used as the base for
  # the doc location. This should be the root of the doc location, where
  # the readme is located. It uses the doc_path setting to build the
  # URLs for the API documentation. This defaults to nil.
  config.remote_url = nil

  # If you would like to precompile your own assets, you can disable auto-compilation.
  # This defaults to true
  config.precompile_assets = true
end
