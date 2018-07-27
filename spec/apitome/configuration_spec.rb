require "spec_helper"

describe Apitome::Configuration do
  describe 'parent_controller' do
    class TestController < ActionController::Base; end

    before do
      Apitome.setup do |config|
        config.parent_controller = 'TestController'
      end
      if Apitome.const_defined?(:DocsController)
        # If the class is already loaded, it needs re-loaded to pick up the config change
        Apitome.send(:remove_const, :DocsController)
        load "apitome/docs_controller.rb"
      end
    end

    it 'inherits from the TestController' do
      expect(Apitome::DocsController).to be < TestController
    end
  end
end
