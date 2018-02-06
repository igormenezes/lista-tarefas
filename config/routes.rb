Rails.application.routes.draw do
  devise_for :users

  root 'user#index'

  get '/list/show' => 'list#show'
  post 'list/add' => 'list#add'

  get '/users', to: redirect(path: 'users/sign_up')
end
