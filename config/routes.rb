Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations" }

  root "products#index"
  resources :users
  resources :addresses, only: [:new, :create]
  resources :products
  post "pay" => "users#pay"
  get "register_cregit_card" => "users#register_cregit_card"
  get "search" => "products#search"
  get "buyproduct" => "products#buyproduct"
  get "userlogout" => "users#userlogout"
  get "creditcard" => "users#creditcard-registration"
end
