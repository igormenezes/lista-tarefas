require 'rails_helper'

RSpec.describe Favorite, type: :model do
	before(:all) do
		@user = User.new(email: 'teste@yahoo.com.br', password: '123456')
		@user.save
	end

	it 'show favorite' do
		current_user = User.new(email: 'teste2@yahoo.com.br', password: '123456')
		current_user.save

		#CONDITIONS ACCEPT
		#
		#PUBLIC
		#OTHER USER
		#NOT ADD FAVORITES

		#List1 - PUBLIC | OTHER USER | ADD FAVORITES = NOT
		list1 = List.new(name: 'teste1', available: 1, active: 1, user_id: @user.id)
		list1.save

		task = Task.new(description: 'teste1', list_id: list1.id)
		task.save
		task = Task.new(description: 'teste2', list_id: list1.id)
		task.save
		task = Task.new(description: 'teste3', list_id: list1.id)
		task.save

		#List2 - PRIVATE | OTHER USER | NOT ADD FAVORITES = NOT
		list2 = List.new(name: 'teste2', available: 0, active: 1, user_id: @user.id)
		list2.save

		task = Task.new(description: 'teste1', list_id: list2.id)
		task.save

		#List3 - PUBLIC | CURRENT USER | NOT ADD FAVORITES = NOT
		list3 = List.new(name: 'teste3', available: 1, active: 1, user_id: current_user.id)
		list3.save

		task = Task.new(description: 'teste1', list_id: list3.id)
		task.save

		#List4 PUBLIC | OTHER USER | ADD FAVORITES = NOT
		list4 = List.new(name: 'teste4', available: 1, active: 1, user_id: @user.id)
		list4.save

		task = Task.new(description: 'teste1', list_id: list4.id)
		task.save

		#List5 PUBLIC | OTHER USER | NOT ADD FAVORITES = YES
		list5 = List.new(name: 'teste5', available: 1, active: 1, user_id: @user.id)
		list5.save

		task = Task.new(description: 'teste1', list_id: list5.id)
		task.save
		task = Task.new(description: 'teste2', list_id: list5.id)
		task.save
		task = Task.new(description: 'teste3', list_id: list5.id)
		task.save

		#ADD FAVORITES BY CURRENT USER
		favorites = Favorite.new(user_id: current_user.id, list_id: list1.id)
		favorites.save

		#ADD FAVORITES BY OTHER USER
		favorites = Favorite.new(user_id: @user.id, list_id: list4.id)
		favorites.save

		#ADD FAVORITES BY CURRENT_USER
		favorites = Favorite.new(user_id: current_user.id, list_id: list4.id)
		favorites.save

		#ADD FAVORITES BY OTHER USER
		favorites = Favorite.new(user_id: @user.id, list_id: list5.id)
		favorites.save

		favorites = Favorite.select(:id, :list_id)
		.where('favorites.user_id = ?', current_user)

		lists = List.select(:id, :name)
		.joins('LEFT JOIN tasks ON tasks.list_id = lists.id')
		.joins('LEFT JOIN favorites ON favorites.list_id = lists.id')
		.where('favorites.user_id = ?', current_user.id)
		.group(:id)

		tasks = Task.select(:id, :description, :list_id)
		.joins('LEFT JOIN lists ON lists.id = tasks.list_id')
		.joins('LEFT JOIN favorites ON favorites.list_id = lists.id')
		.where('favorites.user_id = ?', current_user.id)

		expect(favorites.length).to eq 2 #quantity favorites

		expect(lists.length).to eq 2 #quantity lists

		expect(tasks.length).to eq 4 #quantity tasks
	end

	after(:all) do
		@user.destroy
	end
end
