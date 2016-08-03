Rails.application.routes.draw do
  devise_for :users,
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  root "static_pages#home"

  resources :users, only: [:edit, :update]
  resources :exams, only: [:index, :create, :new]

  namespace :admin do
    root "static_pages#home"
    resources :subjects
    resources :users, except: [:new, :create]
    resources :questions, except: :show
  end
end
