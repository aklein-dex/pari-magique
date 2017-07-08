Rails.application.routes.draw do

  resources :rankings
  devise_for :users
  root 'static_pages#home_root'
  
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
    resources :tournaments, :stadia, :teams
  end

  namespace :manager do
    resources :games
  end
end
