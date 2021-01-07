Rails.application.routes.draw do
  get 'contents/index'
  root to: "contents#index"

  resources :contents, only: [:index]

end
