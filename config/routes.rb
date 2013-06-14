Operations::Application.routes.draw do

  resources :datacenters

  root :to => 'datacenters#index'


  match 'datacenters/:id/viewport/:viewport' => 'datacenters#set_viewport',
    :constraints => { :id => /\d+/,:viewport => /month|week/ },
    :as => 'datacenters_viewport'

  match 'doubleview/:view' => 'datacenters#set_doubleview',
    :as => 'datacenters_doubled', :via => :get  

  match 'datacenters/:id/reservate/:year/:month/:day/:shift' => 'datacenters#day_reserve',
    :constraints => { :id => /\d+/, :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/, :shift => /day|night/ },
    :as => 'datacenters_day_reserve'

  match 'datacenters/:id/confirm/:year/:month/:day/:coll_id' => 'datacenters#day_confirm',
    :constraints => { :id => /\d+/, :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/,  :coll_id => /\d+/ },
    :as => 'datacenters_day_confirm'

  match 'datacenters/:id/destroy/:year/:month/:day/:coll_id' => 'datacenters#day_destroy',
    :constraints => { :id => /\d+/, :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/,  :coll_id => /\d+/ },
    :as => 'datacenters_day_destroy'

  match 'datacenters/:id/manage_days/:year/:month/:day' => 'datacenters#admin_manage_days',
    :constraints => {:id => /\d+/, :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/ },
    :as => 'datacenters_admin_manage_days'

  match 'datacenters/:id/admin_process' => 'datacenters#admin_process_days',
    :as => 'datacenters_admin_process_days', :via => :post




  

  devise_for :users, :path_prefix => 'auth', :skip => [:registrations] 
  resources :users


  

#  match 'day_collections/quick' => 'day_collections#quick_reservations',
#    :as => 'day_collection_quick', :via => :post
  
  # The priority is based upo order of creation:
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
  # match ':controller(/:action(/:id))(.:format)'
end
