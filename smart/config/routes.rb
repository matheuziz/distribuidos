Rails.application.routes.draw do
  root 'application#index'
  resources :tvs
  resources :acs
  resources :lights
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
