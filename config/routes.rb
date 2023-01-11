Rails.application.routes.draw do
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
