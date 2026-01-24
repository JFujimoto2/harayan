Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#home"

  # Static pages
  get "about", to: "pages#about"
  get "business", to: "pages#business"
  get "recruit", to: "pages#recruit"
  get "contact", to: "pages#contact"

  # Stores
  get "stores", to: "stores#index"
  get "stores/8108", to: "stores#hachijuhachi", as: :store_8108
  get "stores/a-kyoto", to: "stores#a_kyoto", as: :store_a_kyoto
  get "stores/b-kyoto", to: "stores#b_kyoto", as: :store_b_kyoto

  # Legacy redirect (shops -> stores)
  get "shops", to: redirect("/stores")

  # Contact form submission
  post "contact", to: "contacts#create"
end
