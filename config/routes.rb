Rails.application.routes.draw do

  root to: 'home#index'

  get 'search', to: 'home#search', as: 'search'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }, skip: [:sessions] 
    as :user do
      get 'login' => 'devise/sessions#new', :as => :new_user_session
      post 'login' => 'devise/sessions#create', :as => :user_session
      delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    end

  devise_scope :user do
    get "/signup" => "users/registrations#new"
    get "/profile" => 'users/registrations#edit'
  end

  resources :tags

  # resources :responsibilities

  # post "/tasks/new", to: 'tasks#create', as: "post_new_task"
  # get "/tasks/new", to: 'tasks#create', as: "create_new_task"
  # get "/tasks/complete", to: 'tasks#complete', as: "complete_tasks"
  # get "/tasks/all", to: 'tasks#all', as: 'all_tasks'

  scope "/tasks" do
    get'/new', to: 'tasks#new_quick_task', as: "new_quick_task"
    get'/all', to: 'tasks#all_tasks', as: "all_tasks"

  end

  # post "/projects/new", to: "projects#create", as: "post_new_project"

  resources :projects do
    get :overdue, on: :collection
    get :complete, on: :collection

    resources :comments, :notes, shallow: true

    resources :tasks, shallow: true do 
      get :complete, on: :collection, to: "tasks#complete"
      get :overdue, on: :collection, to: "tasks#overdue"
    end
    
  end

  namespace :admin do 
    get 'dashboard' => 'dashboard#index', :as => :dashboard
    get 'tags' => 'dashboard#tags', :as => :tags
    get 'users' => 'dashboard#users', :as => :users
    get 'users/:id' => 'dashboard#user_edit', :as => :user_edit
  end

end
