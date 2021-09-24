Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/contact"
    get "static_pages/about"
    get "static_pages/help"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/search", to: "rooms#search"
    resources :carts, only: :index do
      collection do
        post :add
        post :change    
        delete :remove
      end
    end
    resources :users
    resources :rooms
    resources :account_activations, only: :edit
    resources :receipts, only: %i(index show create) do
      collection do
        post :cancel_booking
      end
    end
    namespace :admin do
      root "admins#index"
      resources :receipts, only: %i(edit update) do
        collection do
          put :approved
          put :reject
        end
      end
    end
  end
end
