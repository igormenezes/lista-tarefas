Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
  	get '/login', to: 'devise/sessions#new'
  end

  devise_scope :user do
  	get '/register', to: 'devise/registrations#new'
  end
end
