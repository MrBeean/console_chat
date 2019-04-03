RSpec.describe UserController do
  it 'creates user' do
    params = {
      name: 'Васютка',
      email: 'vasya@mail.com',
      password: '321'
    }

    UserController.create_user(params)
    user = User.last
    aggregate_failures 'expected results' do
      expect(user.name).to eql(params[:name].downcase)
      expect(user.email).to eql(params[:email])
    end
  end
end
