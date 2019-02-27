Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login', to: 'auth#create'
      get '/profile', to: 'clients#profile'
      get '/reviews', to: 'movings#reviews'
      post '/estimate', to: 'movings#estimate'
      resources :movings
      resources :movers, only: [:index]
      resources :clients
      resources :items
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
