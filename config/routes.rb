Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, path: :account, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    root controller: 'users/sessions', action: :new
  end

  resources :users, :tests

  namespace :api do
    namespace :v1 do
      resources :tests, only: [:index, :show]
      resources :submissions, only: [:create]
      resources :users, only: [] do
        post :sign_in, on: :collection
      end
    end
  end
end
