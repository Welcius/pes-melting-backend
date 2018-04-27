Rails.application.routes.draw do
  resources :votes
  resources :comments
  resources :events
  #  root 'events#new'
    
    post '/users/:user_id/events', to: 'events#create'
    post '/users/:user_id/events/:event_id', to: 'events#update'
    post '/users/:user_id/events/:event_id', to: 'events#destroy'
    
    post '/users/:user_id/:event_id/comments', to: 'comments#create'
    post '/users/:user_id/:event_id/comments/:id', to: 'comments#update'
    post '/users/:user_id/:event_id/comments/:id', to: 'comments#destroy'
    
    post '/users/:user_id/events/:event_id/votes', to: 'votes#create'
    post '/users/:user_id/events/:event_id/votes/:id', to: 'votes#update'
    post '/users/:user_id/events/:event_id/votes/:id', to: 'votes#destroy'
    
end
