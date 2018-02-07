require 'rails_helper'

RSpec.describe List, type: :model do
	before(:all) do
		@user = User.new(email: 'teste@yahoo.com.br', password: '123456')
   		@user.save

		@list = List.new(name: 'teste2', available: 1, user_id: @user.id)
		@list.save
	end

	it "add new list and task" do
		list = List.new(name: 'teste', available: 1, user_id: @user.id)
		expect(list.save).to eq true

		task = Task.new(name: 'teste', list_id: list.id)
		expect(task.save).to eq true
	end

	it "add list repeated" do
		list = List.new(name: 'teste2', available: 1, user_id: @user.id)
		expect(list.save).to eq false
	end

	after(:all) do
		@list.destroy
		@user.destroy
	end
end
