Rails.application.routes.draw do
  devise_for :users,
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  root "static_pages#home"

  resources :users, only: [:edit, :update]

  namespace :admin do
    root "static_pages#home"
    resources :subjects, only: [:new, :create, :index]
  end
end
