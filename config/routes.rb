Rails.application.routes.draw do
  post 'users/create', to: 'users#create'
  post 'users/login', to: 'users#login'
  post 'alerts/create', to: 'alerts#create'
  delete 'alerts/delete/:id', to: 'alerts#delete'
  get 'alerts', to: 'alerts#index'
end
