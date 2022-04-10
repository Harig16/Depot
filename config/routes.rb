Rails.application.routes.draw do
  resources :orders
  resources :line_items do
    member do
      post :remove_item
    end
  end
  resources :carts
  root to: 'store#index', as: "store_index"
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
