Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :items
  resources :orders
  resources :carts
  resources :order_items, only: %i[create destroy]
  resources :orders, only: %i[create show]
  post 'order_items/:id/add' => 'order_items#add_quantity', as: 'order_items_add'
  post 'order_items/:id/reduce' => 'order_items#reduce_quantity', as: 'order_items_reduce'
  get '/contact' => 'static_pages#contact'
  get '/about' => 'static_pages#about'
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  scope 'superadmin', module: 'admin', as: 'admin' do
    resources :users
  end

  get '/search' => 'items#filter'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
