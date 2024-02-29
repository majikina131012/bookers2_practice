Rails.application.routes.draw do
   devise_for :users
  get '/top' => 'homes#top'
  get 'home/about' => 'home#about', as: 'about'
  get 'search' => 'searches#search', as: 'search'
  # get 'homes/about' => 'homes#about', as: 'about'
 
  # controllers: {
  # registrations: 'users/registrations',
  # sessions: 'users/sessions'
  # }
  
  root to: 'homes#top'
  resources :books, only: [:index, :show, :create,:destroy,:edit, :update] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :index, :update,] do
    member do
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
    end  
end
