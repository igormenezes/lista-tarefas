require 'rails_helper'

RSpec.describe List, type: :model do
	before(:all) do
		@user = User.new(email: 'teste@yahoo.com.br', password: '123456')
		@user.save
	end

	it "add new list and task" do
		list = List.new(name: 'teste', available: 1, user_id: @user.id)
		expect(list.save).to eq true

		task = Task.new(description: 'teste', list_id: list.id)
		expect(task.save).to eq true
	end

	it "add list repeated" do
		list = List.new(name: 'teste2', available: 1, user_id: @user.id)
		list.save

		list = List.new(name: 'teste2', available: 1, user_id: @user.id)
		expect(list.save).to eq false
	end

	it "show lists by user" do
		current_user = User.new(email: 'teste2@yahoo.com.br', password: '123456')
		current_user.save

		list = List.new(name: 'teste1', available: 1, active: 1, user_id: @user.id)
		list.save

		list = List.new(name: 'teste2', available: 1, active: 0, user_id: @user.id)
		list.save

		list = List.new(name: 'teste3', available: 1, active: 1, user_id: current_user.id)
		list.save

		lists = List.select(:all)
		.where('lists.user_id = ? AND active = ?', @user.id, 1)

		expect(lists.size).to eq 1
	end

	it "show all lists and tasks other users" do
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

		lists = List.select(:id, :name)
		.joins('LEFT JOIN tasks ON tasks.list_id = lists.id')
		.joins('LEFT JOIN favorites ON favorites.list_id = lists.id')
		.where('lists.available = ? 
			AND lists.user_id <> ? 
			AND (favorites.list_id NOT IN(SELECT list_id FROM favorites WHERE favorites.user_id = ?) OR favorites.user_id IS NULL)', 1, current_user.id, current_user.id)
		.group(:id)

		tasks = Task.select(:id, :description, :list_id)
		.joins('LEFT JOIN lists ON lists.id = tasks.list_id')
		.joins('LEFT JOIN favorites ON favorites.list_id = lists.id')
		.where('lists.available = ? 
			AND lists.user_id <> ? 
			AND (favorites.list_id NOT IN(SELECT list_id FROM favorites WHERE favorites.user_id = ?) OR favorites.user_id IS NULL)', 1, current_user.id, current_user.id)

		expect(lists.length).to eq 1 #quantity lists

		expect(tasks.length).to eq 3 #quantity tasks
	end

	after(:all) do
		@user.destroy
	end
end
