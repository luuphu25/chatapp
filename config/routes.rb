Rails.application.routes.draw do
  resources :messages do
    collection do
      get :sent
      get :received
    end
  end

  resources :friendships
  resources :sessions, only: [:new, :create]
  resources :users

  get 'sign_in' => 'sessions#new'
  delete 'log_out' => 'sessions#destroy'  
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
