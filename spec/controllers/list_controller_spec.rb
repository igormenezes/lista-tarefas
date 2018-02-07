require 'rails_helper'

RSpec.describe ListController, type: :controller do
	login_user

	before(:all) do
	end

	it "save new list and task" do
		post 'add', params: {
			list: {
				name: 'teste',
				available: 1
			},
			task:['teste', 'teste2']
		}

		expect(response).to redirect_to('/')
  	end

  	it "show list" do
  		get 'show'
		expect(response).to have_http_status(200)
  	end

  	after(:all) do
  	end
end
