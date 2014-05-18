Fisher::Application.routes.draw do
  resources :profiles
  root to: "home#index"
end