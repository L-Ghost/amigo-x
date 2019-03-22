Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :users do
    resources :groups, only: [] do
      collection do
        get :my_groups
      end
    end
  end
  
  resources :groups, only: [:show]
  
end
