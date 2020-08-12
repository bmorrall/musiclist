Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

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
  resources :albums, concerns: :paginatable, only: [:index, :show, :edit, :update] do
    resource :refresh, module: :albums, only: [:show, :create]
  end
  resources :artists, concerns: :paginatable, except: [:new, :create] do
    resource :refresh, module: :artists, only: [:create]
  end

  root to: "albums#index"
end
