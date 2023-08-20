Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  

  scope module: :public do
  root to: "homes#top"
  get "homes/about"=>"homes#about", as: "about"
  get "search" => "searches#search"
  
  resources :songs do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :update] do
   member do
    get :favorites
   end
  end
  get "/user/check"=>"users#check"
  patch "/user/withdraw" => "users#withdraw"
  end
  
  namespace :admin do
  resources :songs, only: [:index, :show, :destroy]
  
  resources :genres, only: [:index, :create, :edit, :update]
  
  resources :users, only: [:index, :show, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
