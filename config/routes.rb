Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users,
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  root "static_pages#home"

  resources :users, only: [:edit, :update]
  resources :exams, except: :destroy
  resources :suggest_questions, except: :show

  namespace :admin do
    root "static_pages#home"
    resources :subjects
    resources :users, except: [:new, :create]
    resources :questions, except: :show
    resources :exams, only: [:index, :edit, :update]
    resources :suggest_questions, only: [:index, :update, :show]
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
