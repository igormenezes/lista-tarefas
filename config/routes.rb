Rails.application.routes.draw do
  devise_for :users

  root 'list#show'

  get 'list/new' => 'list#new'
  post 'list/add' => 'list#add'
  get 'list/all' => 'list#all'

  get 'task/edit/:id' => 'task#edit'
  post 'task/update' => 'task#update'

  post 'favorite/add' => 'favorite#add'

  match '*path' => redirect('/'), via: :get
end
