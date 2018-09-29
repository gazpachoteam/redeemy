Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"
  get "catalog", to: "pages#catalog"

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      post "/request_token" => "tokens#request_token"
      post "/authenticate_token" => "tokens#authenticate_token"

      resources :redeemables
      resources :providers
      resources :redemptions
      resources :point_types, only: %i[index]
      resources :customers, only: %i[index show]

      post "/answers" => 'answers#get'
    end
  end

  get 'dashboard', to: "dashboard/dashboard#index", as: "bank_dashboard"
  namespace :dashboard do
    resources :providers do
    end
  end

  get 'provider_admin/:provider_id', to: "provider_admin/dashboard#index", as: "dashboard_for_provider"
  namespace :provider_admin do
    resources :providers do
      resources :redemptions, only: [:index]
      resources :redeemables, only: [:index]
    end
  end
end
