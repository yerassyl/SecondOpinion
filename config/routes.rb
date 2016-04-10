Rails.application.routes.draw do

  # devise routes
  devise_for :users

  # default root routes for each role
  authenticated :user, ->(u) { u.has_role?(:manager) } do
    root to: 'managers#index', as: :manager_root
  end
  authenticated :user, ->(u) { u.has_role?(:client) } do
    root to: 'clients#index', as: :client_root
  end

  # all the routes in the block will ask for authentication first
  # if not authenticated, user will be redirected to sign in page
  authenticate :user do

    resources :managers, only: [:index] do
      collection do
        get :rejected
        get :accepted
      end
    end
    resources :clients, only: [:index,:new,:show] do
      collection do
        post 'accept', action: :accept
        post 'reject', action: :reject
      end
    end

    resources :patients, only: [:new,:create,:show] do
      collection do
        get 'familyHistories'
        post :create_familyHistory
        delete :delete_familyHistory
        get 'allergies'
        post 'create_allergy', action: :create_allergy
        delete 'delete_allergy', action: :delete_allergy

        get 'diseases'
        post 'create_disease', action: :create_disease
        delete 'delete_disease', action: :delete_disease

        get 'new_medical_situation'
        post 'create_medical_situation', action: :create_medical_situation

        get 'load_more'
      end
    end

    resources :doctors do
      member do
        patch :update_resume
      end
    end
    resources :call_backs, only: [:index, :show] do
      collection do
        get :incoming
        get :rejected
        get :accepted
      end
    end
    resources :conversations, only: [:index, :show, :destroy]
    resources :messages, only: [:new, :create]

  end

  # not authorized routes
  resources :call_backs, only: [:create]
  # routes that do not need authentication must be declared here
  root 'landing_page#index'
  get 'access_denied' => 'landing_page#access_denied'
  get 'leave_callback' => 'landing_page#leave_callback'
  post 'send_resume' => 'landing_page#send_resume'



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
