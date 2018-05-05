Rails.application.routes.draw do
  
    get '/users/:user_id/events', to: 'events#index' #<- ok
    post '/users/:user_id/events', to: 'events#create' #<- ok
    put '/users/:user_id/events/:event_id/event', to: 'events#update' #<- ok
    delete '/users/:user_id/events/:event_id/event', to: 'events#destroy' #F<- ok
    get '/events/:event_id/event', to: 'events#show' #<- ok
    
    get '/users/:user_id/events/:event_id/comments', to: 'comments#index'  #<- ok
    post '/users/:user_id/events/:event_id/comments', to: 'comments#create'  #<- ok
    put '/users/:user_id/events/:event_id/comments/:comment_id/comment', to: 'comments#update'#<- ok
    delete '/users/:user_id/events/:event_id/comments/:comment_id/comment', to: 'comments#destroy'#<- ok
    
    get '/users/:user_id/events/:event_id/votes', to: 'votes#index'
    post '/users/:user_id/events/:event_id/votes', to: 'votes#create'
    delete '/users/:user_id/events/:event_id/votes/:event_id/vote', to: 'votes#destroy'
 

 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/auth' do
    post 'register', to: 'users#register'
    post 'activate', to: 'users#activate'
    post 'login' => 'user_token#create'
  end

  scope 'users' do
    scope ':user_id' do
      delete '', to: 'users#delete'
      scope 'profile' do
        get '', to: 'profiles#show'
        post '', to: 'profiles#create'
        put '', to: 'profiles#update'
        post 'avatar', to: 'profiles#set_avatar'
      end
    end
  end
  
  scope 'locations' do
    get 'universities', to: 'locations#index', defaults: {type: 'University'}
    get 'universities/:university_id/faculties', to: 'locations#index', defaults: {type: 'Faculty'}
  end

end
