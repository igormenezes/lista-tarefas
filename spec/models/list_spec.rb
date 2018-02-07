require 'rails_helper'

RSpec.describe List, type: :model do
	before(:all) do
		@user = User.new(email: 'teste@yahoo.com.br', password: '123456')
   		@user.save
	end

	it "add new list and task" do
		list = List.new(name: 'teste', available: 1, user_id: @user.id)
		expect(list.save).to eq true

		task = Task.new(name: 'teste', list_id: list.id)
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

	after(:all) do
		@user.destroy
	end
end
