Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "posts/index" => "posts#index"
  get "posts/:id" => "posts#show"

  get "/" => "home#top"
  get "about" => "home#about"


  resources :blogs
     root "home#top"

end
