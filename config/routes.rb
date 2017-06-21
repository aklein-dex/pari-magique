Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#home_root'
  
  get 'static_pages/home'
  get '/rules', to: 'static_pages#rules'

  resources :users
  resources :members
  resources :leagues
  resources :guesses
  resources :games
  resources :requests

  namespace :admin do
    resources :tournaments, :stadia, :teams
  end
end
