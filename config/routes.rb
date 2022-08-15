Rails.application.routes.draw do

  resources :enrollments
  devise_for :users
  resources :lessons
  resources :courses do
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  get 'home/index'
  get 'home/activity'
  root 'home#index'
  
  # root "static_pages#landing_page"
  # get 'privacy_policy', to: "static_pages#privacy_policy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
