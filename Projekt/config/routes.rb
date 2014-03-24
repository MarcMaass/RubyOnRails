GermanSportsEmblem::Application.routes.draw do
   
  # General routes for login, logout, registration
  match '/dosb' => 'sessions#gse', :via => :get
  match '/login' => 'sessions#create', :via => :post
  match '/logout' => 'sessions#destroy', :via => :delete 
  match '/register' => 'athletes#registration', :path => 'register', :via => :get
  match '/register' => 'athletes#create', :path => 'register', :via => :post
  
  # autocompletion routes
  get 'autocomplete_location' => 'locations#autocomplete_location_postal_code'
  get 'autocomplete_orga_unit_name' => 'organization_units#autocomplete_organization_unit_name'
  get 'autocomplete_sport_faci_name' => 'sport_facilities#autocomplete_sport_facility_name'
  get 'autocomplete_athlete_email' => 'athletes#autocomplete_athlete_email'
  
  namespace :athletes do
    resources :performances, :only => [:index, :show]
  end
   
  resources :athletes, :only => [:index] do
    collection do
      get '/profile' => 'athletes#show', :as => :profile
      # Ajax Adress-Form request and update location method
      get '/profile/address_form' => 'athletes#address_form', :as => :address_form
      put '/profile/change_location' => 'athletes#update_location', :as => :update_location
      # Ajax Password-Form request and update password method
      get '/profile/password_form' => 'athletes#password_form', :as => :password_form
      put '/profile/change_password' => 'athletes#update_password', :as => :update_password
      # Ajax OrgaUnit-Form request, add OrgaUnit and delete OrgaUnit method
      get '/profile/orga_unit_form' => 'athletes#orga_unit_form', :as => :orga_unit_form
      put '/profile/orga_unit/add' => 'athletes#add_orga_unit', :as => :add_orga_unit
      delete '/profile/orga_unit/delete' => 'athletes#delete_orga_unit', :as => :delete_orga_unit
      # Ajax Profile-Picture form
      get '/profile/picture_form' => 'athletes#picture_form', :as => :picture_form
      put '/profile/picture_form/update' => 'athletes#update_picture', :as => :update_picture
      delete '/profile/picture_form/delete' => 'athletes#delete_picture', :as => :delete_picture  
    end
  end
  
  namespace :examiners do
    get 'organization_unit' => 'organization_units#show'
    get 'organization_unit/edit/:id' => 'organization_units#edit', :as => :edit_organization_unit
    put 'organization_unit/update/:id' => 'organization_units#update', :as => :update_organization_unit
    get 'organization_unit/sport_faci/new' => 'organization_units#new_sport_facility', :as => :new_sport_facility
    post 'organization_unit/:id/sport_faci' => 'organization_units#create_sport_facility', :as => :create_sport_facility
    get 'organization_unit/sport_faci/:id' => 'organization_units#show_sport_facility', :as => :show_sport_facility
    resources :performances, :only => [:show, :create] do
      collection do
        get 'new' => 'performances#index_new', :as => :index_new
        get 'new/:category_name' => 'performances#new', :as => :new
        get 'athlete_form'
        get 'athlete_mobile_form'
        get 'edit' => 'performances#show'
        get 'search_performances' => 'performances#search_performance', :as => :search  
      end
    end
  end
  
  resources :examiners, :only => [:index, :update] do
    get '/profile' => 'athletes#show', :as => :profile, :on => :collection
  end

  namespace :district_chiefs do
    get '/member_management' => 'members#index', :as => :member_management
    get '/search_member' => 'members#search_member', :as => :search_member
    put '/upgrade/:id' => 'members#upgrade_member', :as => :upgrade
    put '/downgrade/:id' => 'members#downgrade_member', :as => :downgrade
    resources :organization_units
    resources :performances, :except => [:new, :edit, :destory]
    resources :test_appointments, :path => 'appointments'  
  end
  
  resources :district_chiefs, :only => [:index, :update] do
    collection do
      get '/profile' => 'athletes#show', :as => :profile
    end
  end
  
  resources :disciplines, :only => [:index] do
    collection do
      get '/hallo' => 'disciplines#show', :as => :show
      get '/:category' => 'disciplines#index_discipline', :as => :index
    end
  end
  
  root :to => 'sessions#athletes' # root to the login screen
  
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
  # match ':controller(/:action(/:id))(.:format)'
end
