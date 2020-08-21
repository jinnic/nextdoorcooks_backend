Rails.application.routes.draw do
  resources :likes, only: [:create, :index, :destroy]
  resources :experiances
  resources :recipes
  resources :ratings
  resources :users, only: [:create, :index, :destroy]
  resources :items, only: [:create, :update]
  # resources :status_updates do
  #   resources :likes
  #   resources :recipes do
  #     resources :likes
  #   end
  # end
  
  get '/likes/:id', to: "likes#likes_by_user"
  post "/login", to: "users#login" 
  get "/autologin", to: "users#autologin"
  get "/logout", to: "users#logout"
  patch "/profile", to: "users#profile"

  post '/follow/:id', to: "users#follow"
  post '/unfollow/:id', to: "users#unfollow"

  get '/users/:id/following', to: "users#following"
  get '/users/:id/followers', to: "users#followers"
  
  # get ":username/recipes", to: "users#recipes"
  # get ":username", to: "users#find_user"


  # namespace :api do
  #   namespace :v1 do
  #     resources :users, only: [:create]
  #     post '/login', to: 'auth#create'
  #     get '/profile', to: 'users#profile'
  #   end
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
