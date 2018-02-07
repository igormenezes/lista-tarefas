require 'rails_helper'

RSpec.describe ListController, type: :controller do
	login_user

	before(:all) do
	end

	it "add" do
		post 'add', params: {
			list: {
				name: 'teste',
				available: 1
			},
			task:['teste', 'teste2']
		}

		expect(response).to redirect_to('/')
  	end

  	it "show" do
  		get 'show'
		expect(response).to have_http_status(200)
  	end

  	it "new" do
  		get 'new'
		expect(response).to have_http_status(200)
  	end

  	it "all" do
  		get 'all'
  		expect(response).to have_http_status(200)
  	end

  	after(:all) do
  	end
end
