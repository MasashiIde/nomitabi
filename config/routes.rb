Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root :to => 'public/homes#top'
  get '/admin' => 'admin/homes#top', as: 'admin'
  get '/about' => 'public/homes#about', as: 'about'

  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
    resources :posts, except: [:new, :create]
  end

  scope module: :public do
    get 'users/unsubscribe'
    patch 'users/withdraw'
    resources :posts do
      collection do
        get 'search'
      end
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :users, except: [:new, :create, :destroy] do
      collection do
        get 'search'
      end
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      patch 'release'
      patch 'nonrelease'
    end
    resources :notifications, only: :index
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
