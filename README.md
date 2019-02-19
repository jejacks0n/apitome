Apitome
=======

[![Gem Version](https://img.shields.io/gem/v/apitome.svg)](https://rubygems.org/gems/apitome)
[![Dependency Status](https://gemnasium.com/modeset/apitome.svg)](https://gemnasium.com/modeset/apitome)
[![Build Status](https://img.shields.io/travis/jejacks0n/apitome.svg)](https://travis-ci.org/jejacks0n/apitome)
[![Code Climate](https://img.shields.io/codeclimate/github/modeset/apitome.svg)](https://codeclimate.com/github/modeset/apitome)
[![Test Coverage](https://codeclimate.com/github/modeset/apitome/badges/coverage.svg)](https://codeclimate.com/github/modeset/apitome)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

Apitome is a API documentation tool for Rails built on top of the great rspec DSL included in
[rspec_api_documentation](https://github.com/zipmark/rspec_api_documentation) (RAD). It's designed to display the
documentation generated by RAD in either a single page (with scrollspy), or on individual pages, and uses Bootstrap3 for
most of the basic styling and [highlight.js](https://github.com/isagalaev/highlight.js) for code highlighting.

You can provide a markdown file that will be displayed as the README page, and by taking advantage of its modular view
structure you can override any number of views and partials to customize the output. You can also specify custom css and
javascript if you want to do fancier things or change how it looks.


## Installation

Add it to your Gemfile.

```ruby
gem "apitome"
```

Optionally run the install generator to get the initializer and an initial readme file (doc/api.md).

```
rails generate apitome:install
```

Update your `spec_helper.rb` to adjust how RAD outputs its results -- Apitome reads these JSON files to generate the
documentation.

```ruby
RspecApiDocumentation.configure do |config|
  config.format = :json
end
```


## Usage

You can view your documentation at the default `api/docs` route.


## Configuration

After installation, your app will have an apitome initializer (app/config/initializers/apitome.rb). You will find the following parameters that can be used to customize apitome. Note: Restart rails after changing any of these parameters.

<dl>

<dt> mount_at </dt><dd>
  This determines where the Apitome routes will be mounted. Changing this to "/api/documentation" for instance would allow you to browse to http://localhost:3000/api/documentation to see your api documentation. Set to nil and mount it yourself if you need to.<br/>

  <b>default:</b> <code>"/api/docs"</code>
</dd>

<dt> root </dt><dd>
  This defaults to Rails.root if left nil. If you're providing documentation for an engine using a dummy application it can be useful to set this to your engines root.. E.g. <code>Application::Engine.root</code><br/>

  <b>default:</b> <code>nil</code>
</dd>

<dt> doc_path </dt><dd>
  This is where rspec_api_documentation outputs the JSON files. This is configurable within RAD, and so is configurable here.<br/>

  <b>default:</b> <code>"doc/api"</code>
</dd>

<dt> parent_controller </dt><dd>
  Set a parent controller that Apitome::DocsController inherits from. Useful if you want to use a custom `before_action`.<br/>

  <b>default:</b> <code>"ActionController::Base"</code>
</dd>

<dt> title </dt><dd>
  The title of the documentation -- If your project has a name, you'll want to put it here.<br/>

  <b>default:</b> <code>"Apitome Documentation"</code>
</dd>

<dt> layout </dt><dd>
  The main layout view for all documentation pages. By default this is pretty basic, but you may want to use your own application layout.<br/>

  <b>default:</b> <code>"apitome/application"</code>
</dd>

<dt> code_theme </dt><dd>
  We're using [highlight.js](https://github.com/isagalaev/highlight.js) for code highlighting, and it comes with some great themes. You can check [here for themes](http://softwaremaniacs.org/media/soft/highlight/test.html), and enter the theme as lowercase/underscore.<br/>

  <b>default:</b> <code>"default"</code>
</dd>

<dt> css_override </dt><dd>
  This allows you to override the css manually. You typically want to require `apitome/application` within the override, but if you want to override it entirely you can do so.<br/>

  <b>default:</b> <code>nil</code>
</dd>

<dt> js_override </dt><dd>
  This allows you to override the javascript manually. You typically want to require `apitome/application` within the override, but if you want to override it entirely you can do so.<br/>

  <b>default:</b> <code>nil</code>
</dd>

<dt> readme </dt><dd>
  You can provide a "README" style markdown file for the documentation, which is a useful place to include general information. This path is relative to your doc_path configuration.<br/>

  <b>default:</b> <code>"../api.md"</code>
</dd>

<dt> single_page </dt><dd>
  Apitome can render the documentation into a single page that uses scrollspy, or it can render the documentation on individual pages on demand. This allows you to specify which one you want, as a single page may impact performance.<br/>

  <b>default:</b> <code>true</code>

<dt> url_formatter </dt><dd>
  You can specify how urls are formatted using a Proc or other callable object.  Your proc will be called with a resource name or link, giving you the opportunity to modify it as necessary for in the documentation url.<br/>

  <b>default:</b> <code>-> (str) { str.gsub(/\.json$/, '').underscore.gsub(/[^0-9a-z]+/i, '-') }</code>
</dd>

<dt> precompile_assets </dt><dd>
  By default all assets that ship with this library are precompiled by the asset pipeline. If you would prefer to control this yourself, you can disable it by changing this to false.<br/>

  <b>default:</b> <code>true</code>
</dd>

<dt> http_basic_authentication </dt><dd>
  If <code>remote_url</code> is enabled, you can fetch the remote docs using HTTP Basic Authentication by setting the configuration to an array of the user and password. Usage: <code>http_basic_authentication = ['user', 'password']</code><br/>

  <b>default:</b> <code>nil</code>
</dd>
=======

When you install Apitime an initializer file (app/config/initializers/apitome.rb) is generated that contains good
documentation for each configuration directive. Otherwise you can get a refresher by checking the
[Apitome Configuration](https://github.com/modeset/apitome/wiki/Apitome-Configuration) article.

## Customization

You can put custom views and partials in your own `views/apitome/docs` -- check the repo here for
[examples](https://github.com/modeset/apitome/tree/master/app/views/apitome/docs). You can put any partial in your own
path and they will be overridden.

Additional customization can come in the form of providing custom css and javascript. You can do this by creating the
files you want (that often times require the default assets in the gem), and then configure Apitome to use those instead
of the defaults.


## License

Licensed under the [MIT License](http://creativecommons.org/licenses/MIT/)

Copyright 2013 [Mode Set](https://github.com/modeset)


## Make Code Not War
![crest](https://secure.gravatar.com/avatar/aa8ea677b07f626479fd280049b0e19f?s=75)
