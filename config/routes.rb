doc_routes = proc { |doc_name|
  proc {
    root to: "docs#index", doc_name: doc_name.to_s, as: "#{doc_name}_docs"
    get "/simulate/*path", to: "docs#simulate", doc_name: doc_name.to_s
    get "/*path", to: "docs#show", doc_name: doc_name.to_s unless Apitome.configuration.single_page
  }
}

Apitome::Engine.routes.draw do
  if Apitome.configuration.doc_path.is_a?(Hash)
    Apitome.configuration.doc_path.except(:default).each_key do |doc_name|
      scope "/#{doc_name}" do
        instance_eval(&doc_routes.call(doc_name))
      end
    end

    if Apitome.configuration.doc_path.has_key?(:default)
      instance_eval(&doc_routes.call(:default))
    end
  else
    instance_eval(&doc_routes.call(:default))
  end
end
