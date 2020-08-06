Rails.application.routes.draw do
  resources :csp_violations, only: [:create]
  require "sidekiq/web"
  require "admin_constraint"
  mount Sidekiq::Web => "/sidekiq", constraints: AdminConstraint
  # Auth0 Session Routes
  get "auth/sign_in" => "auth#new", as: :auth_sign_in
  get "auth/sign_out" => "auth#sign_out", as: :auth_sign_out
  delete "auth/sign_out" => "auth#destroy"

  get "callback" => "auth#callback"
  get "auth/failure" => "auth#failure"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :albums, only: [:index, :show] do
    resource :refresh, module: :albums, only: [:show, :create]
  end

  root to: "albums#index"
end
