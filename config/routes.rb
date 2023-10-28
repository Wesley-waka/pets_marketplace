Rails.application.routes.draw do
  resources :messages
  resources :favourite_ads
  resources :ad_reviews
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup',
    account_confirmation: 'account_confirmation'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  post '/stripe-webhooks', to: 'stripe_webhooks#receive'
  post 'message', to: 'messages#create'
  mount ActionCable.server, at: '/cable'
  devise_scope :user do
    # get 'account_confirmation/:confirmation_token', to: 'confirmations#show', as: :confirmation
    post 'account_confirmation', to: 'users/confirmations#show', as: :confirmation
    put 'update_profile', to: 'users/registrations#update'
  end

  namespace :api do
    namespace :v1 do
      resources :password do
        collection do
          post :forgot
          post :reset
        end
      end
      resources :ads
      resources :profiles do
        collection do
          put :update_profile
          get :show_profile
        end
      end

      resources :social_login do
        collection do
          post :social_login
        end
      end
    end
  end
end
