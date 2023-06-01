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
    resources :subjects do
      get 'new_child', on: :member
      post 'create_child', on: :member
    end
    resources :courses do
        post :publish, on: :member
        post :unpublish, on: :member
        get :rollback, on: :member
        get 'search', on: :collection
    end
    resources :subject_schedules
    namespace :admin do
      get 'dashboard' => 'dashboard#index'
      resources :users, controller: 'users' do
        resource :profile, only: [:edit, :update], module: :users
      end
      resources :students, controller: 'students' do
        resource :profile, only: [:edit, :update], module: :students
        get 'search', on: :collection
      end
      resources :instructors, controller: 'instructors' do
        resource :profile, only: [:edit, :update], module: :instructors
        # get 'search', on: :collection
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