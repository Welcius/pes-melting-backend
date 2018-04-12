Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/auth' do
    post 'register', to: 'users#register'
    post 'activate', to: 'users#activate'
    post 'login' => 'user_token#create'
  end
end
