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
      resources :addresses do
        member do
          patch 'default_address'
        end
      end
      resources :papers
      resources :vehicles do
        delete '/destroy_image/:id', to: 'vehicles#destroy_image', as: 'destroy_image'
      end
    end

    get '/admin', to: redirect('/admin/dashboard')
    namespace :admin do
      get 'dashboard', to: 'admin#index'
      resources :users
      scope :options do
        resources :vehicle_brands
        resources :vehicle_types
      end
      resources :vehicle_options
    end

    resources :searches, path: 'search'
    resources :vehicles, only: [:show]
    # resources :checkout
    namespace :checkout do
      post 'confirm', action: :confirm
    end
    resources :orders
    if Rails.env.production? || Rails.env.development?
      get '*path' => redirect('/404.html')
    end
  end
end
