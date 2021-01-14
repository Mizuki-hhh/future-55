Rails.application.routes.draw do
  devise_for :users
  get 'contents/index'
  root to: "contents#index"

  resources :contents do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
