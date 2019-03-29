require 'rspec'
require_relative '../lib/database'

describe 'Класс работы с DataBase' do
  before(:all) do
    current_path = File.dirname(__FILE__)
    db_path = current_path + '/Fixtures/console.test.db'
    @db = DataBase.new(db_path)
    @query = "SELECT Name FROM Users WHERE Name = 'Jack'"
    @boolean = true
  end

  it 'принадлежность созданного объекта к классу DataBase' do
    expect(@db.instance_of?(DataBase)).to eq true
  end

  it 'преобразуте ДБ в Хэш' do
    ii = nil
    @db.action_with_db(@query, @boolean).each {|i| ii = i}
    expect(ii.class).to eq Hash
  end
end