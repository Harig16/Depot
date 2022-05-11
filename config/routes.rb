Rails.application.routes.draw do
  get '/admin', to: 'admin#index'
  controller :sessions do
    get "login" => :new 
    post "login" => :create 
    delete "logout" => :destroy 
  end

  get "password/", to: "passwords#edit", as: "edit_password"
  patch "password/", to: "passwords#update"

  resources :users
  resources :orders
  resources :line_items do
    member do
      post :remove_item
    end
  end
  resources :carts
  #root to: 'store#index', as: "store_index"
  resources :products do
    member do
      get :who_bought
    end
  end

  scope '(:locale)' do
    resources :carts
    resources :orders
    resources :line_items
    root 'store#index', as: "store_index", via: :all
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
