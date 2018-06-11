Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # aquesta no pot anar a dins de auth perquè si no es detecta com a pishing
  get 'confirm' => 'users#confirm'
  
  scope 'auth' do
    post 'register', to: 'users#register'
    post 'activate', to: 'users#activate'
    post 'login' => 'user_token#create'
    post 'reset' => 'users#reset'
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
  
  scope 'search' do
    get 'events', to: 'searches#event'
    get 'profiles', to: 'searches#profile'
    get 'universities', to: 'searches#university'
    get 'faculties', to: 'searches#faculty'
  end
  
  scope 'comments' do
    scope ':comment_id' do
      put '', to: 'comments#update'
      delete '', to: 'comments#destroy'
    end
  end
  
  scope 'events' do
    get '', to: 'events#index'
    post '', to: 'events#create'
    scope ':event_id' do
      get '', to: 'events#show'
      put '', to: 'events#update'
      delete '', to: 'events#destroy'
      get 'attendees', to: 'events#attendees'
      scope 'comments' do
        get '', to: 'comments#index'
        post '', to: 'comments#create'
      end
      scope 'votes' do
        post '', to: 'votes#create'
        scope 'self' do
          get '', to: 'votes#show'
          delete '', to: 'votes#destroy'
        end
      end
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
