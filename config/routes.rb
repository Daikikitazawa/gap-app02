Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "login" => "users#login_form"
  post "login" => "users#login"

  get "users/index" => "users#index"
  get "signup" => "users#new"
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  get "users/:id" => "users#show"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  get "posts/:id" => "posts#show"

  get "/" => "home#top"
  get "about" => "home#about"


  resources :blogs
     root "home#top"

end
