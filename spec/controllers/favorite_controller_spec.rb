require 'rails_helper'

RSpec.describe FavoriteController, type: :controller do
	login_user

	before(:all) do
	end

	it "add favorite" do
		list = List.new(name: 'teste', available: 1)
		list.save

		post 'add', params: {id: 1}
		expect(JSON.parse(response.body)['success']).to eq true
	end

	it "show favorite" do
		get 'show'
		expect(response).to have_http_status(200)
	end

	it 'remove favorite' do
		list = List.new(name: 'teste', available: 1)
		list.save
		
		favorite = Favorite.new(user_id: @user.id, list_id: list.id)
		favorite.save

		post 'remove', params: {id: favorite.id}
		expect(JSON.parse(response.body)['success']).to eq true	
	end

	after(:all) do
	end
end
