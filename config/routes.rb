Rails.application.routes.draw do
  namespace :internal_api do
    resources :recipes, only: [:index]
    resources :categories, only: [:index]
  end

  root 'app#index'
end
