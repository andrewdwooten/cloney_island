Rails.application.routes.draw do

  # get 'downvotes/create'
  #
  # get 'downvotes/destroy'
  #
  # get 'upvote/create'
  #
  # get 'upvote/destroy'

  root to: 'home#show', as: 'root'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get '/password/edit', to: "passwords#edit", as: :edit_password
  post '/password/edit', to: "passwords#update"

  resources :questions

  resources :upvotes, only: [:create, :destroy]
  resources :downvotes, only: [:create, :destroy]

  resources :users
  resources :answers, only: [:create, :destroy]
  resources :comments, only: [:create]
end
