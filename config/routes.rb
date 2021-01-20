Rails.application.routes.draw do
  devise_for :users
  get 'contents/index'
  root to: "contents#index"

  resources :contents do
    resources :comments, only: :create
    post '/favorite/:content_id' => 'favorites#favorite', as: 'favorite'
    delete '/favorite/:content_id' => 'favorites#unfavorite', as: 'unfavorite'
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'search'
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
    end
  end

  resources :categories, only: :show

  resources :users, only: [:show] do
    get :favorites, on: :collection
  end
  
end
