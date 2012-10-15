Bcapp::Application.routes.draw do


  resources :useradmins

  resources :categories

  resources :cmtvotes

  resources :postvotes

  resources :users
    resources :posts
     # resources :comments
      resources :posts do
      resources :comments
    end
  resources :comments

  resources :homepages

  resources :users do
    resources :posts do
      resources :postvotes
    end
  end

  resources :users do
    resources :posts do
      resources :comments do
        resources :cmtvotes
      end
    end
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
     match '/searchcont' => 'posts#searchcont', :as => 'searchcont'
     match '/contentsearch' => 'posts#contentsearch', :as => 'contentsearch'

     match '/adminmp' => 'homepages#adminmp', :as => 'adminmp'
     match '/adminactions' => 'homepages#adminactions', :as => 'adminactions'
     match '/actcategory' => 'homepages#actcategory', :as => 'actcategory'
     match '/addcategory' => 'homepages#addcategory', :as => 'addcategory'
     match '/delcategory' => 'homepages#delcategory', :as => 'delcategory'
     match '/assignrole' => 'homepages#assignrole', :as => 'assignrole'
     match '/delusers' => 'homepages#delusers', :as => 'delusers'
     match '/logout' => 'homepages#logout', :as => 'logout'

     match '/postvoter' => 'posts#postvoter', :as=> 'postvoter'
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
  root :to => 'homepages#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
