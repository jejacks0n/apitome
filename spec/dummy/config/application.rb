require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"

Bundler.require

module Dummy
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.session_store :cookie_store, key: '_dummy_session'
    config.secret_token = 'bc510a13d2fb96575782e90e9f2f64afc0ba4e63e5869b6139613686f104d4d3dd92ee696468de5bcbbb74daedb702d3da97554efbc6792abe75091b9df0a2ab'
    config.secret_key_base = 'bc510a13d2fb96575782e90e9f2f64afc0ba4e63e5869b6139613686f104d4d3dd92ee696468de5bcbbb74daedb702d3da97554efbc6792abe75091b9df0a2ab'
    config.assets.enabled = true
    config.assets.version = '1.0'
  end
end
