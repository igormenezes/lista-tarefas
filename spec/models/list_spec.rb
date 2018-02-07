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
		user = User.new(email: 'teste2@yahoo.com.br', password: '123456')
		user.save

		list = List.new(name: 'teste1', available: 1, active: 1, user_id: @user.id)
		list.save

		list = List.new(name: 'teste2', available: 1, active: 0, user_id: @user.id)
		list.save

		list = List.new(name: 'teste3', available: 1, active: 1, user_id: user.id)
		list.save

		lists = List.select(:all)
		.where('lists.user_id = ? AND active = ?', @user.id, 1)

		expect(lists.size).to eq 1
	end

	it "show all lists and tasks other users" do
		user = User.new(email: 'teste2@yahoo.com.br', password: '123456')
		user.save

		list = List.new(name: 'teste1', available: 1, active: 1, user_id: @user.id)
		list.save

		task = Task.new(description: 'teste1', list_id: list.id)
		task.save
		task = Task.new(description: 'teste2', list_id: list.id)
		task.save
		task = Task.new(description: 'teste3', list_id: list.id)
		task.save

		list = List.new(name: 'teste2', available: 0, active: 1, user_id: @user.id)
		list.save

		task = Task.new(description: 'teste1', list_id: list.id)
		task.save
		task = Task.new(description: 'teste2', list_id: list.id)
		task.save
		task = Task.new(description: 'teste3', list_id: list.id)
		task.save

		list = List.new(name: 'teste3', available: 1, active: 1, user_id: user.id)
		list.save

		task = Task.new(description: 'teste1', list_id: list.id)
		task.save
		task = Task.new(description: 'teste2', list_id: list.id)
		task.save
		task = Task.new(description: 'teste3', list_id: list.id)
		task.save

		lists = List.select(:id, :name)
		.joins('LEFT JOIN tasks ON tasks.list_id = lists.id')
		.where('available = ? AND user_id <> ?', 1, user.id)
		.group(:id)

		tasks = Task.select(:id, :description)
		.joins('LEFT JOIN lists ON lists.id = tasks.list_id')
		.where('available = ? AND user_id <> ?', 1, user.id)
		
		expect(lists.length).to eq 1 #quantity lists

		expect(tasks.length).to eq 3 #quantity tasks
	end

	after(:all) do
		@user.destroy
	end
end
