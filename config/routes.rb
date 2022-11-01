Rails.application.routes.draw do
  
  devise_for :customers, skip: [:passwords], controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    root 'homes#top'
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    put 'customers/information' => 'customers#update'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    delete 'cart_products/destroy_all' => 'cart_products#destroy_all', as: 'destroy_all_cart_products'
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/confirm' => 'orders#error'
    get 'orders/thanks' => 'orders#thanks', as: 'thanks'
    
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :products, only: [:index, :show] do
      resources :cart_products, only: [:create, :update, :destroy]
    end
    resources :cart_products, only: [:index]
    resources :orders, only: [:new, :index, :create, :show]
  end
  
  
  devise_for :admins, skip: [:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :products, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
