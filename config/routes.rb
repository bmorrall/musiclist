Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :albums, only: [:index, :show] do
    resource :refresh, module: :albums, only: [:show, :create]
  end

  root to: "albums#index"
end
