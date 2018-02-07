require 'rails_helper'

RSpec.describe Task, type: :model do
	before(:all) do
		@user = User.new(email: 'teste@yahoo.com.br', password: '123456')
		@user.save
	end

	it 'show tasks by list and user' do
		user = User.new(email: 'teste2@yahoo.com.br', password: '123456')
		user.save

		list = List.new(name: 'teste1', available: 1, active: 1, user_id: @user.id)
		list.save
		task = Task.new(name: 'teste', active: 1, list_id: list.id)
		task.save
		task = Task.new(name: 'teste2', active: 1, list_id: list.id)
		task.save

		list2 = List.new(name: 'teste2', available: 1, active: 1, user_id: @user.id)
		list2.save
		task = Task.new(name: 'teste2', active: 1, list_id: list2.id)
		task.save

		list3 = List.new(name: 'teste3', available: 1, active: 1, user_id: user.id)
		list3.save
		task = Task.new(name: 'teste3', active: 1, list_id: list3.id)
		task.save

		tasks = Task.select(:name, :active)
		.joins('LEFT JOIN lists ON lists.id = tasks.list_id')
		.where('lists.id = ? AND lists.user_id = ?', list.id, @user.id)

		expect(tasks.size).to eq 2
	end

	after(:all) do
		@user.destroy
	end
end
