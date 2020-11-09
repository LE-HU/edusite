Rails.application.routes.draw do
  devise_for :users
  resources :courses do
    get :purchased, :pending_review, :created, on: :collection
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :enrollments do
    get :my_students, on: :collection
  end
  root "home#index"
  get "activity", to: "home#activity"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
