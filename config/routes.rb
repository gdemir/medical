Medical::Application.routes.draw do

  root :to => 'home#index'

  match "home" => "home#index"
  match "about" => "home#about"
  match "contact" => "home#contact"

  match "home/consult_destroy" => "home#consult_destroy"
  match "home/consult_destroy/:id/:patient_id" => "home#consult_destroy"

  namespace :home do
    get   :index
    get   :consult_register
    get   :consult_query
  end
  post  "home/consult_register"
  post  "home/department_query"
  post  "home/consult_query"
  post  "home/patient_query"

  match "/admin" => "admin#index"
  namespace :admin do
    get  :login
    get  :logout
    post :sign_in

    get  :index
    get  :profile
    post :profile_update
    post :approval
    get  :help

    resources :drugs do
      get :destroy
    end
    post "drugs/update"

    resources :departments do
      get :destroy
    end
    post "departments/update"

    resources :doctors do
      get :destroy
    end
    post "doctors/update"

    resources :patients do
      get :destroy
    end
    post "patients/update"


    match "consults/all" => "consults#all"
    match "consults/:id/state" => "consults#state"
    match "consults/:id/payment" => "consults#payment"

    match "consults/:patient_id/patient" => "consults#patient"

    match "consults/:id/drugspdf" => "consults#drugspdf"
    match "consults/:id/invoicepdf" => "consults#invoicepdf"
    match "consults/:id/:trial_type_id/trialtypepdf" => "consults#trialtypepdf"
    resources :consults do
      get :destroy
    end

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

    resources :drug_uses do
      get :destroy
    end
    post "drug_uses/update"

    match "trial_requests/all" => "trial_requests#all"
    match "trial_requests/:id/:state/state" => "trial_requests#state"
    resources :trial_requests do
      get :destroy
    end
    post "trial_requests/update"

    resources :trial_results do
    end
    post "trial_results/update"

    resources :blood_groups do
      get :destroy
    end
    post "blood_groups/update"

    resources :trial_storages do
    end
    post "trial_storages/update"

    resources :drug_storages do
    end
    post "drug_storages/update"

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
