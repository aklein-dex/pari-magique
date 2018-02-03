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
    resources :tournaments, :stadia, :teams, :leagues
  end

  namespace :manager do
    resources :games
  end
end
