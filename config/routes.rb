Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Facebook::Messenger::Server, at: 'bot'

  root 'home#index'
  get '/set_profile', to: 'home#set_messenger_profile'

  resources :responses
end
