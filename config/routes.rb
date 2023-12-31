Rails.application.routes.draw do
 
  get 'searches/search'
  get 'book_comments/create'
  get 'book_comments/destroy'
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  get "search" => "searches#search"
  
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :create, :index] do
    member do
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
  end
end
