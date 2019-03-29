require 'rspec'
require 'sqlite3'
require_relative '../lib/interface'

describe 'Класс работы с Interface' do
  before(:all) do
    @interface = Interface.new
    current_path = File.dirname(__FILE__)
    db_path = current_path + '/fixtures/console.test.db'
    db = SQLite3::Database.open(db_path)
    query = "SELECT Name FROM Users WHERE Name = 'Jack'"
    @db_answer = db.execute(query)
  end

  it 'проверка на наличии имени в БД' do
    expect(@interface.user_exist?("Jack", @db_answer)).to eq true
  end

  it 'выдаёт коректную строку запроса' do
    expect(@interface.make_query_request(2)).to eq "SELECT * FROM Messages WHERE Whom = 'общее'"
    expect(@interface.make_query_request(4, "Jack")).to eq "SELECT * FROM Messages WHERE Whom = 'Jack'"
  end
end