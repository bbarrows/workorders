Rails.application.routes.draw do
  #resources :entries
  #resources :tickets
  #devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }

  #resources :tickets do
  #  member do
  #    post 'entry' => 'ticket#entry'
  #  end
  #end

  post '/searchtickets' => 'tickets#searchtickets'
  post '/alltickets24' => 'tickets#all24'
  post '/download24hour' => 'tickets#download24hour'

  get '/allentries' => 'entries#all'

  resources :tickets, param: :ticket_id

  resources :tickets do
    resources :entries, param: :entry_id
  end

  #resources :tickets, param: :ticket_id
  #resources :tickets, param: :ticket_id do
  #  resource :entries, param: :entry_id
  #end

  root to: "tickets#index"

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
