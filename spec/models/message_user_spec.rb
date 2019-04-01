RSpec.describe Message, type: :model do
  before(:all) do
    @user = User.create(name: 'User_1', email: 'user1@us.ru', password: '123')
    @message = Message.create(text: 'Hello all!', user: @user)
  end

  it 'create valid string' do
    relation = MessagesUsers.create(user: @user, message: @message)
    aggregate_failures 'expected results' do
      expect(relation).to be_valid
      expect(relation.message.text).to eql('Hello all!')
      expect(relation.read).to be false
    end
  end
end
