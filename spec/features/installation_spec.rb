require "spec_helper"

feature "Installation", shell: true do
  before do
    unset_bundler_env_vars

    run_simple("bundle exec rails new testapp --skip-bundle --skip-activerecord")
    cd("testapp")

    append_to_file("Gemfile", %{\ngem 'apitome', path: '../../../'\n})
    run_simple("bundle install#{!ENV["TRAVIS"] ? ' --local' : ''}")
  end

  it "installs the base files" do
    run_simple("bundle exec rails generate apitome:install --trace")
    expect(all_output).to include(<<-OUTPUT.strip_heredoc)
            create  config/initializers/apitome.rb
            create  doc/api.md
            create  public/javascripts/apitome/application.js
            create  public/stylesheets/apitome/application.css
      +============================================================================+
      Congratulations! Apitome was successfully installed.
    OUTPUT
  end

  it "can install without the asset files" do
    run_simple("bundle exec rails generate apitome:install --no-assets --trace")
    expect(all_output).to include(<<-OUTPUT.strip_heredoc)
            create  config/initializers/apitome.rb
            create  doc/api.md
      +============================================================================+
      Congratulations! Apitome was successfully installed.
    OUTPUT
  end
end
