Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  authenticate :user do
    root to: 'dashboard#index'
  

    namespace :admin do
      get 'dashboard' => 'dashboard#index'
      resource :profile, only: [:show, :edit, :update]
      resources :students
      # root to: 'dashboard#index'
    end

    namespace :instructor do
      get 'dashboard' => 'dashboard#index'
      resource :profile, only: [:show, :edit, :update]
      # root to: 'dashboard#index'
    end

    namespace :student do
      get 'dashboard' => 'dashboard#index'
      resource :profile, only: [:show, :edit, :update]
      
      # root to: 'dashboard#index'
    end
  end #End of Authenticate :user do

end #end of rails