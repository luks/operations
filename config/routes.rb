Operations::Application.routes.draw do

  devise_for :users
  


  #resources :day_collections
  resources :days

  match 'day_collections/:year/:month/:day/:shift' => 'day_collections#day',
    :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/, :shift => /day|night/ },
    :as => 'day_collection_day'

  match 'day_collections/admin/:year/:month/:day' => 'day_collections#admin_day',
    :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/ },
    :as => 'day_collection_admin_day'

  match 'day_collections/destroy/:year/:month/:day/:id' => 'day_collections#destroy',
    :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/, :id => /\d+/ },
    :as => 'day_collection_destroy'

  match 'day_collections/confirm/:year/:month/:day/:id' => 'day_collections#confirm',
    :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/, :id => /\d+/ },
    :as => 'day_collection_confirm'

  match 'day_collections/admin/multiple' => 'day_collections#multiple',
    :as => 'day_collection_multiple', :via => :post

  match 'day_collections/set_overview/:overview' => 'day_collections#set_overview',
    :constraints => { :overview => /month|week/ },
    :as => 'day_collection_set_overview'

  match 'day_collections' => 'day_collections#index',
    :as => 'day_collections'



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
