Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations", omniauth_callbacks: 'users/omniauth_callbacks'}


  root "products#index"
  resources :users do
    collection do
      get "purchase"
      get "purchased"
      get "listings"
      get "progress"
      get "completed"
      get "userlogout"
      get "identification"
    end
  end
  resources :addresses, only: [:new, :create, :update, :edit]

  resources :likes, only: [:index]

  resources :products do
    resources :mypayjp, only: [:show]
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :rates, only: [:new, :create, :edit, :update]
  end

  post "pay" => "users#pay"

  get "register_cregit_card" => "users#register_cregit_card"
  get "search" => "products#search"

  resources :category,only: [:index,:show]
  get "creditcard" => "users#creditcard-registration"
  post "testpay/:id" => "mypayjp#create_charge"
end
