Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "articles#index"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get "user_signup", to: "devise/registrations#new"
    get "user_login", to: "devise/sessions#new"
    get "user_logout", to: "devise/sessions#destroy"
    get "user_settings", to: "devise/registrations#edit"
  end

  resource :articles
end
