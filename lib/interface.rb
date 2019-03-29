require 'date'

class Interface

  def make_query_request(input, name = nil, text = nil, whom = nil)
    if input == 1
      query = "INSERT INTO Messages "
      query += "(Name, Time, Text, Whom) VALUES ('#{name}'," +
          " '#{Time.now.strftime('%d.%m.%Y %H:%M:%S')}', '#{text}', 'общее')"
    elsif input == 2
      query = "SELECT * FROM Messages "
      query += "WHERE Whom = 'общее'"
    elsif input == 3
      query = "INSERT INTO Messages "
      query += "(Name, Time, Text, Whom) VALUES ('#{name}'," +
          " '#{Time.now.strftime('%d.%m.%Y %H:%M:%S')}', '#{text}', '#{whom}')"
    elsif input == 4
      query = "SELECT * FROM Messages "
      query += "WHERE Whom = '#{name}'"
    end
    query
  end

  def query_to_login(name)
    "SELECT Name FROM Users WHERE Name = '#{name}'"
  end

  def query_to_registr(name)
    "INSERT INTO Users (Name) VALUES ('#{name}')"
  end

  def user_exist?(name, db_answer)
    name != "" && db_answer.join("\s") == name
  end
end
