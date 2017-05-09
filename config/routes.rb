Rails.application.routes.draw do
  resources :users, only: :create

  mount Facebook::Messenger::Server, at: 'bot'
end
