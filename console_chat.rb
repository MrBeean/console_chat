require_relative 'lib/database'
require_relative 'lib/user'
require_relative 'lib/interface'
require_relative 'lib/message'

current_path = File.dirname(__FILE__)
db_path = current_path + '/data/db/console.test.db'

interface = Interface.new
db = DataBase.new(db_path)

loop do
  choice = nil
  until choice == 1 || choice == 2
    puts "Выберите регистрация или авторизация\nregistr - 1\nlogin - 2"
    choice = STDIN.gets.chomp.to_i
    if choice == 1
      name = ""
      until name.size >= 3
        puts 'Введите ваше Имя(login name)'
        name = STDIN.gets.chomp
        puts 'Имя должно быть не короче трёх символов' if name.size < 3
      end
      user = User.new(name)
      db.action_with_db(interface.query_to_registr(name))
      puts "Регистрация завершена\n\n"
    elsif choice == 2
      name = nil
      db_answer = []
      while interface.user_exist?(name, db_answer) == false
        puts 'Введите имя'
        name = STDIN.gets.chomp
        user = User.new(name)
        db_answer = db.action_with_db(interface.query_to_login(name))
        puts 'Такого имени нет в базе' if interface.user_exist?(name, db_answer) == false
      end
      puts "Авторизация успешна\n\n"
    else
      puts 'Выбор не коректен'
    end
  end

  choice = nil
  while choice != 9
    puts "\n\nВыберите действие:"
    puts "написать общее сообщение - 1\nпрочитать общее сообщение - 2"
    puts "написать личное сообщение - 3\nпрочитать личное сообщенияе - 4"
    puts 'выход - 9'

    choice = STDIN.gets.chomp.to_i
    if choice == 1 || choice == 3
      puts 'Введите текст сообщения'
      text = STDIN.gets.chomp
      if choice == 3
        puts 'Кому хотите отправить сообщение'
        whom = STDIN.gets.chomp
      end
    end
    if [1, 2, 3, 4].include?(choice)
      query = interface.make_query_request(choice, user.name, text, whom)
      db_as_hash = true
      messages = []
      messages = db.action_with_db(query, db_as_hash).map {|str| messages << Message.new(str)}
      messages.each {|i| i.to_s} if [2, 4].include?(choice)
    else
      puts 'Выбор не коректен'
    end
  end
end
