require 'rails_helper'

RSpec.describe FavoriteController, type: :controller do
	login_user

	before(:all) do
	end

	it "add favorite" do
		post 'add', params: {id: 1}
		expect(JSON.parse(response.body)['success']).to eq true
	end


	after(:all) do
	end
end
