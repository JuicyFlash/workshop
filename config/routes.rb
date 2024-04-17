Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "products#index"

  resources :products, only: %i[index], shallow: true  do
    resources :basket_products, only: %i[create destroy] do
      member do
        patch :add
        patch :remove
      end
    end
  end

  resources :baskets, only: %i[show]

  resources :orders, only: %i[index show create]
end
