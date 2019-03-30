require 'active_record'

require_relative 'lib/models/user'
require_relative 'lib/models/message'
require_relative 'lib/database'

DBConnection.connect('development')

def self.cls
  system('cls') || system('clear')
end

cls
user_choice = nil
until user_choice == 1 || user_choice == 2
  puts "Выберите регистрация или авторизация\nДля регистрации нажми - 1\nДля авторизации нажми - 2"
  user_choice = STDIN.gets.chomp.to_i
  if user_choice == 1
    params = {}
    puts "Введите ваше имя\n\n"
    params[:name] = STDIN.gets.chomp
    puts "Введите ваш email\n\n"
    params[:email] = STDIN.gets.chomp
    user = DBConnection.create_user(params)
    user.id ? next : user_choice = nil
  elsif user_choice == 2
    puts 'Введите ваш email'
    email = STDIN.gets.chomp
    user = User.find_by(email: email)
    user ? next : user_choice = nil
    puts 'Пользователя с таким email нет'
  end
end

while user_choice != 9
  puts "\nВыберите действие:\n"
  puts "написать сообщение - 1\nпрочитать общие сообщения - 2"
  puts "прочитать личное сообщения - 3\nпрочитать свои сообщения - 4"
  puts 'выход - 9'

  user_choice = STDIN.gets.chomp.to_i
  if user_choice == 1
    params = {}
    puts 'Введите текст сообщения !! Не более 100 символов!!'
    params[:text] = STDIN.gets.chomp
    puts "Напишите email кому хотите отправить лично\n(Оставьте пустым для отправки всем)"
    params[:whom] = STDIN.gets.chomp
    params[:user] = user
    message = DBConnection.create_message(params)
    message.id ? next : user_choice = nil
  elsif user_choice == 2
    messages = Message.where(whom: [nil, ''])
    messages.each(&:to_s)
  elsif user_choice == 3
    messages = Message.where(whom: user.email)
    messages.each(&:to_s)
  elsif user_choice == 4
    messages = Message.where(user_id: user.id)
    messages.each(&:to_s)
  end
end
