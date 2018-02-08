require 'rails_helper'

RSpec.describe TaskController, type: :controller do
	login_user

	before(:all) do
	end

	it "form to edit task" do
		get 'edit', params: {id: 1}
		expect(response).to have_http_status(200)
	end

	it "update task" do
		list = List.new(name: 'teste', available: 1, user_id: @user.id)
		list.save

		task = Task.new(description: 'teste', active: 1, list_id: list.id)
		task.save

		post 'update', params: {id: task.id,user: @user.id}

		expect(JSON.parse(response.body)['success']).to eq true
	end


	after(:all) do
	end
end
