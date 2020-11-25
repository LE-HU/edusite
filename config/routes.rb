Rails.application.routes.draw do
  devise_for :users, controllers: {
            registrations: "users/registrations",
          }
  resources :courses do
    get :purchased, :pending_review, :created, :unapproved, on: :collection
    resources :lessons, except: [:index] do
      resources :comments, only: [:create, :destroy]
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:new, :create]
    member do
      get :analytics
      patch :approve
      patch :unapprove
    end
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :enrollments do
    get :my_students, on: :collection
  end
  resources :youtube, only: :show
  root "home#index"
  get "activity", to: "home#activity"
  get "statistics", to: "home#statistics"
end
