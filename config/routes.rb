Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#home_root'
  
  get 'static_pages/home'
  get '/rules', to: 'static_pages#rules'

  resources :users
  resources :teams
  resources :stadia
  resources :members
  resources :leagues
  resources :guesses
  resources :games
  resources :requests

  namespace :admin do
    resources :tournaments
  end
end
