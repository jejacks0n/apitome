Apitome::Engine.routes.draw do
  root to: 'docs#index'
  get '/*path', to: 'docs#show'
end
