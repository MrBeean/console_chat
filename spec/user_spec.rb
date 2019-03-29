require 'rspec'
require_relative '../lib/user'

describe 'Класс работы с User' do
  before(:all) do
    @user = User.new('Jack')
  end

  it 'создание нового пользователя' do
    expect(@user.nil?).to eq false
  end

  it 'читает имя пользователя' do
    expect(@user.name).to eq 'Jack'
  end

  it 'возвращает объект класса' do
    expect(@user.instance_of?(User)).to eq true
  end
end