require "spec_helper"

describe Apitome::DocsHelper, type: :helper do
  describe "#resource_link" do
    let(:resource) do
      {
        "examples" => [
          { "link" => "something.json" }
        ]
      }
    end
    subject { helper.resource_link(resource) }

    it "strips the file ending" do
      expect(subject).to eq "/api/docs/something"
    end
  end

  describe "#example_link" do
    let(:example) do
      { "link" => "an-example.json" }
    end
    subject { helper.example_link(example) }

    it "strips the file ending" do
      expect(subject).to eq "/api/docs/an-example"
    end
  end

  describe "#format_scope" do
    it { expect(format_scope("")).to be_blank }
    it { expect(format_scope("item")).to eq("item") }
    it { expect(format_scope(:item)).to eq("item") }
    it { expect(format_scope(%w[item item_id])).to eq("item[item_id]") }
    it { expect(format_scope(%i[item item_id])).to eq("item[item_id]") }
  end
end
