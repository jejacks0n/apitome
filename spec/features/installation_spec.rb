require "spec_helper"

feature "Installation", shell: true do
  before do
    unset_bundler_env_vars

    run_command_and_stop("bundle exec rails new testapp --skip-bundle --skip-activerecord --skip-bootsnap --skip-webpack-install")
    cd("testapp")

    append_to_file("Gemfile", %{\ngem 'apitome', path: '../../../'\n})
    run_command_and_stop("bundle install")
  end

  it "installs the base files" do
    run_command_and_stop("bundle exec rails generate apitome:install --trace")
    out = all_commands.map { |c| c.output }.join("\n")
    expect(out).to include(<<-OUTPUT.strip_heredoc)
            create  config/initializers/apitome.rb
            create  doc/api.md
            create  public/javascripts/apitome/application.js
            create  public/stylesheets/apitome/application.css
      +============================================================================+
      Congratulations! Apitome was successfully installed.
    OUTPUT
  end

  it "can install without the asset files" do
    run_command_and_stop("bundle exec rails generate apitome:install --no-assets --trace")
    out = all_commands.map { |c| c.output }.join("\n")
    expect(out).to include(<<-OUTPUT.strip_heredoc)
            create  config/initializers/apitome.rb
            create  doc/api.md
      +============================================================================+
      Congratulations! Apitome was successfully installed.
    OUTPUT
  end
end
