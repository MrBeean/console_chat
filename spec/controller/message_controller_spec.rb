RSpec.describe MessageController do
  before(:all) do
    @user1 = User.create(name: 'User1', email: 'user1@us.ru', password: '123')
    @user2 = User.create(name: 'User2', email: 'user2@us.ru', password: '123')
  end

  it 'creates global message' do
    message_controller = MessageController.new(User.all)
    params = {
      user: @user1,
      text: 'Всем привет!',
      whom: ''
    }

    message_controller.create_message(params)

    message = Message.find_by(text: 'Всем привет!')
    aggregate_failures 'expected results' do
      expect(message.user.id).to eql(@user1.id)
      expect(message.text).to eql('Всем привет!')
    end
  end

  it 'creates personal message' do
    message_controller = MessageController.new(User.all)
    params = {
      user: @user1,
      text: 'Привет дядя!',
      whom: @user2.email
    }

    message_controller.create_message(params)
    message = Message.find_by(text: 'Привет дядя!')
    message_user = MessagesUsers.last
    aggregate_failures 'expected results' do
      expect(message_user.user.id).to eql(@user2.id)
      expect(message_user.message.id).to eql(message.id)
    end
  end
end
