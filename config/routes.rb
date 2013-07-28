Osp::Application.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'

  resources :videos


  resources :pliks


resources :users, :user_sessions, :news, :images, :statistics, :members, :albums

match 'login' => 'user_sessions#new', :as => :login
match 'logout' => 'user_sessions#destroy', :as => :logout
match 'logowanie' => 'user_sessions#new', :as => :login
match 'rejestracja' => 'users#new'
match 'about' => 'users_#about'
match 'czlonkowie' => 'users_#czlonkowie'
match 'galeria' => 'users_#galeria'
match 'galeria_wszystkie' => 'albums#galeria_wszystkie'
match 'aktualnosci' => 'news#index'
match 'aktualnosci_grupuj' => 'news#group'
match 'imprezy' => 'news#imprezy'
match 'interwencje' => 'news#interwencje'
match 'statystyki' => 'statistics#index'
match 'szkolenia' => 'news#szkolenia'
match 'inne' => 'news#inne'
match 'otwp' => 'news#otwp'
match 'wynajem_sali' => 'users#wynajem_sali'
match '/ftp/upload' => 'images#create'
match '/pozar_plus' => 'statistics#pozar_plus'
match '/pozar_minus' => 'statistics#pozar_minus'
match '/zagrozenia_plus' => 'statistics#zagrozenia_plus'
match '/zagrozenia_minus' => 'statistics#zagrozenia_minus'
match '/alarmy_plus' => 'statistics#alarmy_plus'
match '/alarmy_minus' => 'statistics#alarmy_minus'

root :to => "users_#start"


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
