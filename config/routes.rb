Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, 
                     controllers: { omniauth_callbacks: "omniauth_callbacks" }
  scope "(:locale)", locale: /en|vi/ do
    root 'static_pages#index'
    devise_for :users, skip: :omniauth_callbacks
    as :user do
      get "signup", to: "devise/registrations#new"
      get "signin" => "devise/sessions#new"
      post "signin" => "devise/sessions#create"
      delete "signout" => "devise/sessions#destroy"
    end
    resources :users, only: :index
  end
end
