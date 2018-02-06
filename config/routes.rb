Rails.application.routes.draw do

  resources :rankings
  devise_for :users
  
  devise_scope :user do
    root 'devise/sessions#new'
  end
  
  get 'static_pages/home'
  get '/rules', to: 'static_pages#rules'

  resources :users
  resources :members
  resources :guesses
  resources :requests

  resources :leagues do
    resources :tournaments
  end
  
  namespace :admin do
    resources :tournaments, :leagues
    
    resources :stadia do
      collection { post :import }
    end
    
    resources :teams do
      collection { post :import }
    end
  end

  namespace :manager do
    resources :games do
      collection { post :import }
    end
  end
end
