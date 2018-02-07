module ControllerMacros
  def login_user
    before(:each) do
      @user = User.create(
      	:email => 'teste@yahoo.com.br', 
      	:password => '123456'
      )
      sign_in @user
    end
  end
end