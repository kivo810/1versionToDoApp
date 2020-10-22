Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'tasks#index'
  resources :tasks

  resources :settings, only: [:index]

  scope :settings do
    resources :categories, :tags
  end
end
