require "spec_helper"
require "rails/generators"
require_relative "../../lib/generators/apitome/install/install_generator"

describe Apitome::Generators::InstallGenerator do
  before do
    allow(subject).to receive(:copy_file)
  end

  describe "#copy_initializers" do
    it "installs the initializer and markdown file" do
      subject.copy_initializers
      expect(subject).to have_received(:copy_file).with(
        "templates/initializer.rb",
        "config/initializers/apitome.rb"
      )
      expect(subject).to have_received(:copy_file).with(
        "templates/api.md",
        "doc/api.md"
      )
    end
  end

  describe "#copy_assets" do
    it "installs the expected assets into the public path" do
      subject.copy_assets
      expect(subject).to have_received(:copy_file).with(
        "../../../../app/assets/javascripts/apitome/bundle.js",
        "public/javascripts/apitome/application.js"
      )
      expect(subject).to have_received(:copy_file).with(
        "../../../../app/assets/stylesheets/apitome/bundle.css",
        "public/stylesheets/apitome/application.css"
      )
    end
  end

  describe "#display_post_install" do
    before do
      allow(subject).to receive(:readme)
    end

    it "displays the post install message if the behavior is to invoke" do
      expect(subject).to receive(:behavior).and_return(:invoke)

      subject.display_post_install
      expect(subject).to have_received(:readme).with("POST_INSTALL")
    end

    it "doesn't display a message if the behavior when the behavior is unknown" do
      expect(subject).to receive(:behavior).and_return(:unknown)

      subject.display_post_install
      expect(subject).to_not have_received(:readme).with("POST_INSTALL")
    end
  end

  context "the initializer" do
    before do
      allow(Apitome).to receive(:configure).and_call_original
    end

    it "configures Apitome" do
      load File.expand_path("../../../lib/generators/apitome/install/templates/initializer.rb", __FILE__)
      expect(Apitome).to have_received(:configure)
    end
  end
end
