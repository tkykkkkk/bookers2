Rails.application.routes.draw do
  root to: 'homes#top'
  get "/home/about" => "homes#about", as: "about"
  get "search" => "searches#search"
  devise_for :users
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do 
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end 
  resources :users, only: [:index, :show, :edit, :update] do 
      member do 
       get :follows, :followers
      end 
      resource :relationships, only: [:create, :destroy]
  end 
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
