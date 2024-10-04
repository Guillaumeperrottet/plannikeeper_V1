Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'public', to: 'pages#public'

  # Page de santé
  get "up" => "rails/health#show", as: :rails_health_check

  # Route racine
  root 'pages#home'

  # Route pour le profil utilisateur
  resource :profile, only: [:show]

  resources :objets do
    # Nouvelle route pour accéder aux tâches directement via un objet
    get 'tasks', to: 'tasks#index_for_objet'

    resources :secteurs, only: [:edit, :update] do
      member do
        get 'image', to: 'secteurs#image'
      end
      resources :articles, only: [:create, :index, :show] do
        resources :tasks, only: [:new, :create, :edit, :update, :destroy, :index] do
          # Route pour archiver une tâche
          member do
            patch 'archive', to: 'tasks#archive'
          end
        end
      end
    end
  end
end
