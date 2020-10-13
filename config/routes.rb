Rails.application.routes.draw do
  devise_for :users
  resources :courses do
    resources :lessons
  end
  resources :users, only: [:index, :show, :edit, :update]
  root "home#index"
  get "home/activity"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
