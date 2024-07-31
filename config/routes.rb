Rails.application.routes.draw do
  post 'users/create', to: 'users#create'
  post 'users/login', to: 'users#login'
  post 'alerts/create', to: 'alerts#create'
  delete 'alerts/:id', to: 'alerts#destroy'
  get 'alerts', to: 'alerts#index'
end
