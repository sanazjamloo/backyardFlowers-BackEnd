Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :show, :destroy, :index] do
  resources :flowers, only: [:create, :show, :index, :update, :destroy]
  collection do
    post '/login', to: 'users#login'
    end
  end
end

#Prefix Verb   URI Pattern                           Controller#Action
#user_flowers GET    /users/:user_id/flowers(.:format)     flowers#index
#             POST   /users/:user_id/flowers(.:format)     flowers#create
# user_flower GET    /users/:user_id/flowers/:id(.:format) flowers#show
#             PATCH  /users/:user_id/flowers/:id(.:format) flowers#update
#             PUT    /users/:user_id/flowers/:id(.:format) flowers#update
#             DELETE /users/:user_id/flowers/:id(.:format) flowers#destroy
# login_users POST   /users/login(.:format)                users#login
#       users GET    /users(.:format)                      users#index
#             POST   /users(.:format)                      users#create
#        user GET    /users/:id(.:format)                  users#show
#             DELETE /users/:id(.:format)                  users#destroy
