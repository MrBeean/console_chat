RSpec.describe Message, type: :model do
  before(:all) do
    @user = User.create(name: 'User', email: 'user@us.ru', password: '123')
  end

  it 'is not valid for empty text' do
    message = Message.create(text: nil, user: @user)
    expect(message).not_to be_valid
  end

  it 'is not valid for empty user' do
    message = Message.create(text: 'Hello all!', user: nil)
    expect(message).not_to be_valid
  end

  it 'is not valid with long text' do
    message = Message.create(text: (0..55).to_a.join(''), user: @user)
    expect(message).not_to be_valid
  end

  it 'is valid for' do
    message = Message.create(text: 'Hello there!', user: @user)
    aggregate_failures 'expected results' do
      expect(message).to be_valid
      expect(message.user.email).to eql('user@us.ru')
    end
  end
end
