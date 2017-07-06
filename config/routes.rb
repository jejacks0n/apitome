Apitome::Engine.routes.draw do
  root to: "docs#index"
  get "/simulate/*path", to: "docs#simulate", as: :simulated
  get "/*path", to: "docs#show" unless Apitome.configuration.single_page
end
