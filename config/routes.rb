Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/register', to: 'users#register'
  post '/activate', to: 'users#activate'
end
