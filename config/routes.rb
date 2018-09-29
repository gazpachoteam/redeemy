Rails.application.routes.draw do
  devise_for :users
  devise_for :customers
  root to: "pages#home"
  get "catalog", to: "pages#catalog"

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :providers do
        resources :redemptions
        resources :projects
      end
      resources :point_types, only: %i[index]
      resources :customers, only: %i[index show]

      post "/answers" => 'answers#get'
    end
  end


end
