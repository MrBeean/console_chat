RSpec.describe User, type: :model do
  it 'is not valid for empty name' do
    user = User.create(name: nil, email: 'user@user.ru', password: '123')
    expect(user).not_to be_valid
  end

  it 'is not valid for empty email' do
    user = User.create(name: 'user', email: nil, password: '123')
    expect(user).not_to be_valid
  end

  it 'is not valid for empty password' do
    user = User.create(name: 'user', email: 'user@user.ru', password: nil)
    expect(user).not_to be_valid
  end

  it 'is not valid for wrong email' do
    user = User.create(name: 'user', email: 'user.ru', password: '123')
    expect(user).not_to be_valid
  end

  it 'is valid for' do
    user = User.create(name: 'user', email: 'user@user.ru', password: '123')
    expect(user).to be_valid
  end
end
