ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.resources :sessions
  map.resources :main
  map.resources :home
  map.resources :report
  map.resources :users
  map.resources :flits
  map.page '/page/:id', :controller => 'home', :action => 'page'
  map.search '/search', :controller => 'main', :action => 'search'
  map.tag '/tag', :controller => 'main', :action => 'tag'
  map.unfollow '/unfollow/:username', :controller => 'home', :action => 'unfollow'
  map.follow '/:username/follow', :controller => 'home', :action => 'follow'
  map.follow_via_ajax '/:username/follow_via_ajax', :controller => 'home', :action => 'follow_via_ajax'
  map.following '/:username/following', :controller => 'home', :action => 'following'
  map.followers '/:username/followers', :controller => 'home', :action => 'following'
  map.user_flits '/:username', :controller => 'home', :action => 'show'

#  map.profile '/profile/:username', :controller => "users", :action => "edit"

  map.root :controller => "main"

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
