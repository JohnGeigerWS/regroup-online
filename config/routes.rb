require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :user, :controllers => {:confirmations => 'confirmations'}

  devise_scope :user do
    patch "user/confirmation" => "confirmations#confirm", as: 'confirmation'
    unauthenticated :user do
      root to: 'devise/sessions#new'
    end
    authenticated :user do
      root to: 'live#index'
    end
  end

  get '/support', to: 'support_requests#new', as: 'new_support_request'
  post '/support', to: 'support_requests#create', as: 'create_support_request'

  get 'account', to: 'users#show', controller: 'users'
  post 'account', to: 'users#create', controller: 'users'
  patch 'account', to: 'users#update', controller: 'users'
  resources :users, only: [:create, :update] do
    post 'resend-invitation', to: 'users#resend_invitation', as: 'resend_invitation'
    post 'revoke-invitation', to: 'users#revoke_invitation', as: 'revoke_invitation'
  end

  get '/sessions/:id', to: 'sessions#show', as: 'drive_session' # using `resources` breaks devise sessions
  get '/sessions/:id/check', to: 'sessions#check', as: 'check_drive_session'

  # Staff tickets using omniauth
  get '/npmstaff', to: redirect('/auth/chms')
  match '/auth/:provider/callback', to: 'staff_tickets#create', via: [:get, :post]
  get '/auth/failure', to: 'staff_tickets#failure'

  namespace :webhooks do
    post 'eventbrite/order_placed', to: 'eventbrite#order_placed'
  end

  namespace :admin do
    root to: 'timeslots#index'
    resources :communicators, except: [:show]
    resources :sessions, except: [:show]
    post '/sessions/:id/finish/', to:'sessions#finish', as: 'session_finish'
    post '/sessions/:id/restart/', to:'sessions#restart', as: 'session_restart'
    resources :timeslots, except: [:show]
    resources :users, except: [:show] do
      post 'resend-confirmation', to: 'users#resend_confirmation', as: 'resend_confirmation'
      post 'send-reset-password', to: 'users#send_reset_password', as: 'send_reset_password'
    end
    resources :support_requests, except: [:show]
    authenticate :user, lambda { |u| u.admin_role? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  match "*path", to: "errors#not_found", via: :all

end
