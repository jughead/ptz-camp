require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
  }

  authenticate :user, lambda{ |u| u.admin? } do
    get :admin, to: 'admin/site#home'

    namespace :admin do
      mount Sidekiq::Web => '/sidekiq'
      resources :messages, only: [:index, :create, :new]
      resources :camps do
        member do
          get :dashboard
        end
        resources :delegations
        resources :day_schedules, only: [:index, :edit, :update]
        resources :participants
      end
    end
  end

  resources :camps, path: '', param: :slug, only: :show do
    resource :schedule, controller: :schedule, only: :show
    resources :participants, only: [:new, :index, :create, :edit, :update, :show]
  end

  root to: 'site#home'
end
