Rails.application.routes.draw do
  devise_for :users

  root 'list#show'

  get 'list/new' => 'list#new'
  post 'list/add' => 'list#add'

  match '*path' => redirect('/'), via: :get
end
