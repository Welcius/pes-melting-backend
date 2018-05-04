Rails.application.routes.draw do

  resources :votes
  resources :comments
  resources :events
  resources :users
  #  root 'events#new'
  
    get '/events', to: 'events#index' #<- ok
    post '/users/:user_id/events', to: 'events#create' #<- ok
    put '/users/:user_id/events/:event_id/event', to: 'events#update' #<- ok
    delete '/users/:user_id/events/:event_id/event', to: 'events#destroy' #FALTA
    get '/events/:event_id/event', to: 'events#show' #<- ok
    
    get '/users/:user_id/events/:event_id/comments', to: 'comments#index' 
    post '/users/:user_id/events/:event_id/comments', to: 'comments#create' 
    put '/users/:user_id/events/:event_id/comments/:id', to: 'comments#update'
    delete '/users/:user_id/events/:event_id/comments/:id', to: 'comments#destroy'
    
    get '/users/:user_id/events/:event_id/votes', to: 'votes#create'
    post '/users/:user_id/events/:event_id/votes', to: 'votes#create'
    put '/users/:user_id/events/:event_id/votes/:id', to: 'votes#update'
    delete '/users/:user_id/events/:event_id/votes/:id', to: 'votes#destroy'
 

 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/auth' do
    post 'register', to: 'users#register'
    post 'activate', to: 'users#activate'
    post 'login' => 'user_token#create'
  end

  scope 'users' do
    scope ':user_id' do
      get 'profile', to: 'profiles#show'
      post 'profile', to: 'profiles#create'
      put 'profile', to: 'profiles#update'
      post 'profile/avatar', to: 'profiles#set_avatar'
    end
  end
  
  scope 'locations' do
    get 'universities', to: 'locations#index', defaults: {type: 'University'}
    get 'universities/:university_id/faculties', to: 'locations#index', defaults: {type: 'Faculty'}
  end

end
