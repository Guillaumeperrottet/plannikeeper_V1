Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    authenticated :user do
      root to: 'dashboard#dashboard', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  get 'public', to: 'pages#public'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'
  get '/home', to: 'pages#home' # Nouvelle route pour la page Home

  # Page de santé
  get "up" => "rails/health#show", as: :rails_health_check

  # Route pour le profil utilisateur
  resource :profile, only: [:show]

  resources :objets do
    get 'tasks', to: 'tasks#index_for_objet'

    resources :secteurs, only: [:edit, :update] do
      member do
        get 'image', to: 'secteurs#image'
      end

      resources :articles, only: [:create, :index, :show] do
        resources :tasks, only: [:new, :create, :edit, :update, :destroy, :index] do
          member do
            patch 'archive', to: 'tasks#archive'
          end
        end
      end
    end
  end
end
