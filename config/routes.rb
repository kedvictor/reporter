Reporter::Application.routes.draw do
  
  get "records/index"

  get "records/new"

  get "register" => "users#new", :as => "register" 
  get "login" => "sessions#new", :as => "login" 
  get "logout" => "sessions#destroy", :as => "logout" 
    
  resources :users
  resources :sessions
  resources :records

 
  root :to => 'home#index'

 
end
