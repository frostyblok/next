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

  resources :articles

  get "my_articles", to: "articles#my_articles", as: "my_articles"
  get "article_search", to: "articles#index", as: "article_search"

  get "otp_secrets/:article_id/new", to: "otp_secrets#new", as: "new_otp_secret"
  post "otp_secrets/:article_id", to: "otp_secrets#verify_and_update", as: "otp_secrets"
end
