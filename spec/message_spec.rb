require 'rspec'
require_relative '../lib/message'

describe 'Класс работы с Message' do
  before(:all) do
    hash = {"rowid" => 1, "Name" => "Вася", "Text" => "раз два три", "Whom" => "общее", "Time" => "11.11.1111"}
    @message = Message.new(hash)
  end

  it 'коректное создание параметров' do
    expect(@message.name).to eq 'Вася'
  end
end

