Rails.application.routes.draw do

  root to: 'home#index'

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

  scope "/tasks" do
    get'/new', to: 'tasks#quick_new_task', as: "quick_new_task"
    post'/', to: 'tasks#create', as: "post_quick_new_task"
    get'/all-active-tasks', to: 'tasks#all_active_tasks', as: "all_active_tasks"
    get'/all-complete-tasks', to: 'tasks#all_complete_tasks', as: "all_complete_tasks"
    get'/all-overdue-tasks', to: 'tasks#all_overdue_tasks', as: "all_overdue_tasks"
  end

  resources :projects do
    get :overdue, on: :collection
    get :complete, on: :collection

    post '/delete_collaborator', to: 'projects#delete_collaborator'

    resources :comments, :notes, shallow: true

    resources :tasks, shallow: true do 
      get :complete, on: :collection, to: "tasks#complete"
      get :overdue, on: :collection, to: "tasks#overdue"
    end
  end

  patch '/edit_user_project_permission', to: 'user_projects#edit_user_project_permission'

  namespace :admin do 
    get 'dashboard' => 'dashboard#index', :as => :dashboard
    get 'tags' => 'dashboard#tags', :as => :tags
    get 'users' => 'dashboard#users', :as => :users
    get 'users/:id' => 'dashboard#user_edit', :as => :user_edit
  end

end
