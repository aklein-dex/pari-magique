Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#home'
  
  get 'static_pages/home'
  get '/rules', to: 'static_pages#rules'

  resources :users
  resources :teams
  resources :stadia
  resources :tournaments
  resources :members
  resources :leagues
  resources :guesses
  resources :games
end
