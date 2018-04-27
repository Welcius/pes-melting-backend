Rails.application.routes.draw do

  resources :votes
  resources :comments
  resources :events
  resources :users
  #  root 'events#new'
    
    post '/users/:user_id/events', to: 'events#create' #<- ok
    put '/users/:user_id/events/:event_id', to: 'events#update' #
    delete '/users/:user_id/events/:event_id', to: 'events#destroy' #
    
    post '/users/:user_id/:event_id/comments', to: 'comments#create' #<- ok
    post '/users/:user_id/:event_id/comments/:id', to: 'comments#update'
    post '/users/:user_id/:event_id/comments/:id', to: 'comments#destroy'
    
    post '/users/:user_id/events/:event_id/votes', to: 'votes#create'
    post '/users/:user_id/events/:event_id/votes/:id', to: 'votes#update'
    post '/users/:user_id/events/:event_id/votes/:id', to: 'votes#destroy'
    
    post 'register', to: 'users#register'
    post 'activate', to: 'users#activate'
    post 'login' => 'user_token#create'

 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/auth' do
    post 'register', to: 'users#register'
    post 'activate', to: 'users#activate'
    post 'login' => 'user_token#create'
  end

end
