Medical::Application.routes.draw do

  root :to => 'home#index'

  match "home" => "home#index"
  match "about" => "home#about"
  match "contact" => "home#contact"

  get   "home/index"
  post  "home/index"
  get   "home/consult_register"
  post  "home/consult_register"
  get   "home/consult_query"
  post  "home/consult_query"
  get   "home/patient_query"
  post  "home/patient_query"
  get   "home/department_query"
  post  "home/department_query"
  match "home/consult_destroy" => "home#consult_destroy"
  match "home/consult_destroy/:id/:patient_id" => "home#consult_destroy"

  match "/admin" => "admin#index"

  namespace :admin do
    get  :login
    get  :logout
    post :sign_in

    get  :index
    get  :profile
    post :profile_update
    get  :help

    resources :drugs do
      get :destroy
    end
    post "drugs/update"

    resources :departments do
      get :destroy
    end
    post "departments/update"

    resources :patients do
      get :destroy
    end
    post "patients/update"

    match "consults/all" => "consults#all"
    resources :consults do
      get :destroy
    end

    resources :doctors do
      get :destroy
    end
    post "doctors/update"

    resources :trial_types do
      get :destroy
    end
    post "trial_types/update"

    match "trials/:trial_type_id/new" => "trials#new"
    resources :trials do
      get :destroy
    end
    post "trials/update"

    resources :admins do
      get :destroy
    end
    post "admins/update"

    resources :invoices do
      get :destroy
    end
    post "invoices/update"

    resources :trial_results
    resources :trial_requests

    resources :people
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
