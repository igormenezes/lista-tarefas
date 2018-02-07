require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
   @user = User.new(email: 'teste@yahoo.com.br', password: '123456')
   @user.save
 end

 it "save new user" do
   user = User.new(email: 'teste2@yahoo.com.br', password: '123456')
   expect(user.save).to eq true
 end

 it "save exists user" do
   user = User.new(email: 'teste@yahoo.com.br', password: '123456')
   expect(user.save).to eq false
 end

 after(:all) do
   @user.destroy
 end
end
