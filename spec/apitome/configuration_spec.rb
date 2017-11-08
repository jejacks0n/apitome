require "spec_helper"

describe Apitome::Configuration do
  describe 'parent_controller' do
    class TestController < ActionController::Base; end

    before do
      Apitome.setup do |config|
        config.parent_controller = 'TestController'
      end
    end

    it 'inherits from the TestController' do
      expect(Apitome::DocsController).to be < TestController
    end
  end
end
