Rails.application.routes.draw do
  devise_for :users,
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  root "static_pages#home"

  resources :users, only: [:edit, :update]
  resources :exams, except: :destroy

  namespace :admin do
    root "static_pages#home"
    resources :subjects
    resources :users, except: [:new, :create]
    resources :questions, except: :show
    resources :exams, only: [:index, :edit, :update]
  end
end
