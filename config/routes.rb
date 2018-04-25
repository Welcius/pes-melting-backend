Rails.application.routes.draw do
  resources :votes
  resources :comments
  resources :events
  resources :messages
    root 'messages#new'
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
