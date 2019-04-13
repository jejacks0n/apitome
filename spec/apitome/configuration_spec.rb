require "spec_helper"

describe Apitome::Configuration do
  subject { described_class }

  before do
    @orig_root = subject.root
    @orig_doc_path = subject.doc_path
  end

  after do
    subject.mount_at = "/api/docs"
    subject.root = @orig_root
    subject.doc_path = @orig_doc_path
  end

  it "has the default configuration" do
    expect(subject.mount_at).to eq("/api/docs")
    expect(subject.root).to eq(Rails.root)
    expect(subject.doc_path).to eq("doc/api")
    expect(subject.parent_controller).to eq("ActionController::Base")
    expect(subject.title).to eq("Apitome Documentation")
    expect(subject.layout).to eq("apitome/application")
    expect(subject.code_theme).to eq("default")
    expect(subject.css_override).to be_nil
    expect(subject.js_override).to be_nil
    expect(subject.readme).to eq("../api.md")
    expect(subject.single_page).to be_truthy
    expect(subject.remote_url).to be_nil
    # expect(subject.url_formatter).to be_truthy
    expect(subject.precompile_assets).to be_truthy
    expect(subject.simulated_response).to be_truthy
  end

  it "allows setting various configuration options" do
    subject.mount_at = "/documentation"
    expect(subject.mount_at).to eq("/documentation")
    subject.doc_path = "docs/api_path"
    expect(subject.doc_path).to eq("docs/api_path")
  end

  it "exposes an API for calling configure with a block" do
    Apitome.configure do |c|
      c.mount_at = "/readthis"
      c.doc_path = "doc/for_api"
    end

    expect(subject.mount_at).to eq("/readthis")
    expect(subject.doc_path).to eq("doc/for_api")
  end

  describe ".root=" do
    it "forces the path provided into a Pathname" do
      subject.root = "/path"
      expect(subject.root).to be_a(Pathname)
    end
  end
end
