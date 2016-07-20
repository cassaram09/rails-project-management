Rails.application.routes.draw do

  root to: 'home#index'

  get '/profile', to: 'home#profile'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }, skip: [:sessions] 
    as :user do
      get 'login' => 'devise/sessions#new', :as => :new_user_session
      post 'login' => 'devise/sessions#create', :as => :user_session
      delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    end

  devise_scope :user do
    get "/signup" => "devise/registrations#new"
    get "/edit-profile" => "devise/registrations#edit"
  end

  resources :comments
  
  resources :notes

  resources :tags

  resources :responsibilities

  resources :tasks, only: [:index, :new, :create] do
    post "/tasks/new", to: 'tasks#create', as: "post_new_task"
    get :complete, on: :collection
  end

  resources :projects do
    get :on_hold, on: :collection
    get :complete, on: :collection
    get :tasks, to: 'projects#tasks'
    post "/tasks", to: 'tasks#create', as: "post_new_task"
    resources :tasks, only: [:show, :edit, :update, :destroy] do 
      get :complete, on: :collection, to: "projects#complete_tasks"
    end
  end

  namespace :admin do 
    get 'dashboard' => 'dashboard#index', :as => :dashboard
    get 'tags' => 'dashboard#tags', :as => :tags
    get 'users' => 'dashboard#users', :as => :users
    get 'users/:id' => 'dashboard#user_edit', :as => :user_edit
    get 'search' => 'dashboard#search', :as => :search

  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
