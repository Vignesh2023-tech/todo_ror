Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get '/index', to: "root#index"
  root "root#index"
  post '/create', to: "root#create"
  delete '/delete/:id', to: "root#delete"
  put '/todos/:id', to: "root#update"

    # User
    get "/signup", to: "user#signup"
    post "/signup", to: "user#create"
    get "/profile", to: "user#profile"
    post "/update", to: "user#update"
    get "/password/reset", to: "user#password_reset_new"
    post "/password/reset", to: "user#password_reset_create"
    get "/password/reset/edit", to: "user#password_reset_edit"
    post "/password/reset/update", to: "user#password_reset_update"

    get "/login", to: "user#login"
    post "/login_user", to: "user#login_user"
    get "/logout", to: "user#logout"
end
