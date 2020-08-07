Rails.application.routes.draw do
  resources :likes
  resources :experiances
  resources :recipes
  resources :raitings
  resources :users, only: [:create, :index]
  get ":username/recipes", to: "users#recipes"
  post "/login", to: "users#login" 
  get "/autologin", to: "users#autologin"
  get "/logout", to: "users#logout"
  patch "/profile", to: "users#profile"
  get ':username/following', to: "users#following", as: "following"
  get ':username/followers', to: "users#followers", as: "followers"
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  # namespace :api do
  #   namespace :v1 do
  #     resources :users, only: [:create]
  #     post '/login', to: 'auth#create'
  #     get '/profile', to: 'users#profile'
  #   end
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
