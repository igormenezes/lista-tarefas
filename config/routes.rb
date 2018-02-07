Rails.application.routes.draw do
  devise_for :users

  root 'list#show'

  get 'list/create' => 'list#create'
  post 'list/add' => 'list#add'

  match '*path' => redirect('/'), via: :get
end
