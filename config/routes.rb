Rails.application.routes.draw do
  devise_for :users
  resources :courses do
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :enrollments
  root "home#index"
  get "home/activity"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
