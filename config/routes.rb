Rails.application.routes.draw do

    post '/users/:user_id/events/:event_id/comments', to: 'comments#create'  #<- ok
    put '/users/:user_id/events/:event_id/comments/:comment_id/comment', to: 'comments#update'#<- ok
    delete '/users/:user_id/events/:event_id/comments/:comment_id/comment', to: 'comments#destroy'#<- ok
    
    get '/users/:user_id/events/:event_id/votes', to: 'votes#index' #<- ok
    post '/users/:user_id/events/:event_id/votes', to: 'votes#create' #<- ok
    delete '/users/:user_id/events/:event_id/vote', to: 'votes#destroy' #<- ok
    get '/users/:user_id/events/:event_id', to: 'votes#assist' #<- ok
    get '/users/:user_id/events/:event_id/assistants', to: 'votes#assistants'
    
    get '/search/events', to: 'searches#event'
    get '/search/profiles', to: 'searches#profile'
    get '/search/universities', to: 'searches#university'
    get '/search/faculties', to: 'searches#faculty'
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/auth' do
    post 'register', to: 'users#register'
    post 'activate', to: 'users#activate'
    post 'login' => 'user_token#create'
  end

  scope 'users' do
    scope ':user_id' do
      delete '', to: 'users#delete'
      get 'events', to: 'events#index'
      scope 'profile' do
        get '', to: 'profiles#show'
        post '', to: 'profiles#create'
        put '', to: 'profiles#update'
        post 'avatar', to: 'profiles#set_avatar'
        get 'faculty', to: 'profiles#show_faculty'
      end
    end
  end
  
  scope '/events' do
    get '', to: 'events#index'
    post '', to: 'events#create'
    scope ':event_id' do
      get '', to: 'events#show'
      put '', to: 'events#update'
      delete '', to: 'events#destroy'
      get 'comments', to: 'comments#index'
    end
  end
  
  scope 'locations' do
    get 'universities', to: 'locations#index', defaults: {type: 'University'}
    get 'universities/:university_id/faculties', to: 'locations#index', defaults: {type: 'Faculty'}
    get ':id', to: 'locations#show'
  end
  
  scope 'chat' do
    # Com que només hi ha un chatroom, passem un paràmetre d'id explícit 1
    get 'users', to: 'chatrooms#connected_users_profiles', defaults: {id: 1}
    get 'messages', to: 'chatrooms#get_messages', defaults: {id: 1}
    post 'messages', to: 'chatrooms#send_message', defaults: {id: 1}
  end

end
