Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/auth' do
    post 'register', to: 'users#register'
    post 'activate', to: 'users#activate'
    post 'login' => 'user_token#create'
  end
  
  get '/users/:user_id/profile', to: 'profiles#show'
  post '/users/:user_id/profile', to: 'profiles#create'
  put '/users/:user_id/profile', to: 'profiles#update'
  
  post '/users/:user_id/profile/avatar', to: 'profiles#set_avatar'
end
