Rails.application.routes.draw do
 
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
end
