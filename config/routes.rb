Rails.application.routes.draw do
  namespace :internal_api do
    resources :recipes, only: [:index, :show]
  end

  root 'app#index'
end
