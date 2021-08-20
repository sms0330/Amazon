Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get("/", {to:"welcome#index", as: "root"}) 
  get("/about", {to:"about#index"})
  get("/contact", {to:"contact#index"})
  post("/contact_submit", {to:"contact#create", as: "contact_submit" })
  get("/new",{to:"bills#new"})
  post("/bill", {to: 'bills#calculate', as: :bill})

#  # Labs for rails CRUD
#  get("/products",to:"products#index")
#  get("/products/new",to:"products#new",as: :new_product)
#  post("/products",to:"products#create")

#  get("/products/:id",to:"products#show",as: :product)
#  delete("/products/:id",to:"products#destroy")
 
#  get("/products/:id/edit",to:"products#edit",as: :edit_product)
#  patch("/products/:id",to:"products#update")


 resources :products do
    resources :pays, only: [:new, :create]
    get '/pays/complete', to: 'pays#complete'
  resources :reviews do
    resources :likes, shallow: true, only: [:create, :destroy]
    resources :votes, shallow: true, only: [:create, :destroy]
  end
  resources :favourites, shallow: true, only: [:create, :destroy]
 end

#  post '/products/:product_id/reviews/:review_id/likes', {to: "likes#create", as: :product_review_likes}
#  delete '/products/:product_id/reviews/:review_id/likes/:id', {to: "likes#destroy", as: :product_review_like}
 
 resources :users, only:[:new, :create]
 resource :session, only:[:new, :create, :destroy]

 get("/dashboard",{to:"users#dashboard"})

 resources :news_articles

 match(
  "/delayed_job",
  to: DelayedJobWeb,
  anchor: false,
  via: [:get, :post]
)

  namespace :api, defaults:{format: :json } do
    namespace :v1 do
      resources :products
      resource :session, only: [:create, :destroy]
      resources :users, only: [:create] do
        get :current, on: :collection # => api/v1/users/current
      end
    end
    match "*unmatched_route", to: "application#not_found", via: :all
  end

end
