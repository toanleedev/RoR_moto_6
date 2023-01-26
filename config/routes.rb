require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users,
             only: :omniauth_callbacks,
             controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  scope '(:locale)', locale: /en|vi/ do
    root 'static_pages#index'
    devise_for :users, skip: :omniauth_callbacks, 
      controllers: { registrations: 'registrations', sessions: "sessions"}

    namespace :account do
      resource :address, only: %i[show create update]
      resource :paper, only: %i[show create update]
      resources :orders, only: %i[index show edit update] do
        member do
          patch 'cancel'
        end
      end
      resource :service_fee, only: :show
    end

    namespace :partners do
      resources :order_manages, only: %i[index show edit update] do
        member do
          get 'checkout'
          patch 'pending'
          patch 'cancel'
          patch 'accept'
          patch 'processing'
          post 'completed'
          patch 'cash_paid'
        end
      end
      resources :vehicles do
        get 'slots', on: :collection
        post 'register_slots', on: :collection
        patch 'update_status', on: :member
        get 'priority', on: :member
        post 'priority_create', on: :member
        post 'priority_upgrade', on: :member
        delete 'destroy_image/:id', to: 'vehicles#destroy_image', as: 'destroy_image'
      end
      resource :statistic, only: %i[show]
      resource :payment_history
      resource :register, only: %i[show create update]
      resource :deposit, only: %i[show create] do
        post 'checkout', on: :collection
      end
    end

    get '/admin', to: redirect('/admin/dashboard') #fix locale
    namespace :admin do
      resource :dashboard
      resources :users, only: %i[index show edit update] do
        member do
          patch 'confirm_paper'
          patch 'reject_paper'
          patch 'block'
          patch 'unblock'
        end
      end
      resources :vehicles, only: %i[index show update] do
        member do
          patch 'accepted'
        end
        patch 'bulk_accepted', on: :collection
      end
      resources :vehicle_options
      resources :orders, only: %i[index show]
      resources :partners, only: %i[index show] do
        member do
          get 'confirm'
          get 'cancel'
        end
      end
    end

    resource :search, only: [:show] do
      get 'vehicle/:id', to: 'searches#detail'
    end

    namespace :checkout do
      post 'confirm', action: :confirm
      get 'complete', action: :complete
      get 'confirmation', action: :confirmation
      post 'payment', action: :payment_paypal
    end
    resources :orders, only: %i[create show edit update]
    resource :notification, only: [:create]
    resource :rating, only: [:create]
    resource :payment do
      member do
        post 'priority'
      end
    end
    resources :messages
    resource :chart do
      collection do
        get 'partner_turnover'
        get 'partner_order'
        get 'partner_vehicle'
        get 'admin_statistic'
      end
    end
    if Rails.env.production? || Rails.env.development?
      get '*path' => redirect('/404.html')
    end
  end
  mount ActionCable.server => '/cable'
end
