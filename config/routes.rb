Rails.application.routes.draw do
  devise_for :users
  resources :courses do
    get :purchased, :pending_review, :created, :unapproved, on: :collection
    resources :lessons
    resources :enrollments, only: [:new, :create]
    member do
      patch :approve
      patch :unapprove
    end
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :enrollments do
    get :my_students, on: :collection
  end
  root "home#index"
  get "activity", to: "home#activity"
  get "statistics", to: "home#statistics"
end
