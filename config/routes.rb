Rails.application.routes.draw do
  devise_for :users
  get 'contents/index'
  root to: "contents#index"

  resources :contents do
    resources :comments, only: :create
    collection do
      get 'get_category_children', defaults: { format: 'json' }
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
    end
  end
  resources :categories, only: :show
  resources :users, only: :show
end
