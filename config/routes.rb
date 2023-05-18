Rails.application.routes.draw do
  

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  authenticate :user do
    root to: 'home#index'
    resource :profile
    resources :subjects
    resources :courses do
      member do
        post :publish
        post :unpublish
        get :rollback
      end
      collection do
        get 'search'
      end
    end
    
    namespace :admin do
      get 'dashboard' => 'dashboard#index'
      resources :students, controller: 'students' do
        resource :profile, only: [:edit, :update, :destroy], module: :students
        collection do
          get 'search'
        end
      end
    end

    namespace :instructor do
      get 'dashboard' => 'dashboard#index'

    end

    namespace :student do
      get 'dashboard' => 'dashboard#index'

    end
  end #End of Authenticate :user do

end #end of rails