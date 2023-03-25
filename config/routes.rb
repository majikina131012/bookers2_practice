Rails.application.routes.draw do
  get '/top' => 'homes#top'
  get 'home/about' => 'home#about', as: 'about'
  # get 'homes/about' => 'homes#about', as: 'about'
  devise_for :users
  # controllers: {
  # registrations: 'users/registrations',
  # sessions: 'users/sessions'
  # }
  
  root to: 'homes#top'
  resources :books, only: [:index, :show, :create,:destroy,:edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :index, :update,]
end
