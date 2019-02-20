Apitome::Engine.routes.draw do
  root to: "docs#index"
  get "/simulate/*path", to: "docs#simulate", as: :simulated if Apitome.configuration.simulated_response
  get "/*path", to: "docs#show" unless Apitome.configuration.single_page
end
