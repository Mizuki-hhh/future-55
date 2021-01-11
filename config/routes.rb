Rails.application.routes.draw do
  devise_for :users
  get 'contents/index'
  root to: "contents#index"

  resources :contents, only: [:index, :new, :create]

end
