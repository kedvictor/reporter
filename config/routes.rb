Reporter::Application.routes.draw do
  
  get "register" => "users#new", :as => "register" 
  get "login" => "sessions#new", :as => "login" 
  get "logout" => "sessions#destroy", :as => "logout" 
    
  resources :users
  resources :sessions

 
  root :to => 'home#index'

 
end
