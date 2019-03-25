Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :users do
    resources :groups, only: [] do
      collection do
        get :my_groups
        get :my_created_groups
      end
    end
  end
  
  resources :groups, only: [:show, :new, :create] do
    member do
      get :add_participant
      patch :confirm_participant
    end
    resources :sessions, only: [:index, :show, :new, :create]
  end

  resources :sessions, only: [] do
    member do
      patch :make_raffle
    end
  end
  
end
