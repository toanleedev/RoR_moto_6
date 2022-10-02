Rails.application.routes.draw do
  devise_for :users,
             only: :omniauth_callbacks,
             controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  scope '(:locale)', locale: /en|vi/ do
    root 'static_pages#index'
    devise_for :users, skip: :omniauth_callbacks, controllers: { registrations: 'registrations' }
    as :user do
      get 'signup', to: 'devise/registrations#new'
      get 'signin', to: 'devise/sessions#new'
      post 'signin', to: 'devise/sessions#create'
      delete 'signout', to: 'devise/sessions#destroy'
    end
    resources :users, only: :index
    namespace :account do
      resource :address, only: %i[show create update]
      resource :paper, only: %i[show create update]
      resources :vehicles do
        delete '/destroy_image/:id', to: 'vehicles#destroy_image', as: 'destroy_image'
      end
      resources :orders, only: %i[index show edit update] do
        member do
          patch 'cancel'
        end
      end
      resources :rental_orders, only: %i[index show edit update] do 
        member do
          patch 'cancel'
          patch 'accept'
          patch 'processing'
          patch 'completed'
        end
      end
    end

    get '/admin', to: redirect('/admin/dashboard') #fix locale
    namespace :admin do
      get 'dashboard', to: 'admin#index'
      resources :users, only: %i[index show]
      resources :vehicle_options
      resources :orders, only: [:index]
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
    end
    resources :orders, only: %i[create show edit update]
    resource :partner
    if Rails.env.production? || Rails.env.development?
      get '*path' => redirect('/404.html')
    end
  end
end
