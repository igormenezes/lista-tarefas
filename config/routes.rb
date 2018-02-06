Rails.application.routes.draw do
  devise_for :users

  root 'user#index'

  get '/users', to: redirect(path: 'users/sign_up')
end
