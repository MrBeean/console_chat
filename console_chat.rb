require 'active_record'

require_relative 'lib/models/user'
require_relative 'lib/models/message'
require_relative 'lib/database'

DBConnection.connect('development')

def self.cls
  system("cls") || system("clear")
end


cls
user_choice = nil
until user_choice == 1 || user_choice == 2
  puts "Выберите регистрация или авторизация\nДля регистрации нажми - 1\nДля авторизации нажми - 2"
  user_choice = STDIN.gets.chomp.to_i
  if user_choice == 1
    puts "Введите ваше имя\n\n"
    name = STDIN.gets.chomp
    puts "Введите ваш email\n\n"
    email = STDIN.gets.chomp
    user = User.create(name: name, email: email)
    user.id ? next : user_choice = nil
    puts 'Такой пользователь уже занят'
  elsif user_choice == 2
    puts 'Введите ваш email'
    email = STDIN.gets.chomp
    user = User.where(email: email).last
    user ? next : user_choice = nil
    puts 'Пользователя с таким email нет'
  end
  puts "\nВведены некорректные данные \n\n"
end

while user_choice != 9
  puts "Выберите действие:\n"
  puts "написать сообщение - 1\nпрочитать общие сообщения - 2"
  puts "прочитать личное сообщения - 3\nвыход - 9"

  user_choice = STDIN.gets.chomp.to_i
  if user_choice == 1
    puts 'Введите текст сообщения'
    text = STDIN.gets.chomp
    puts "Напишите email кому хотите отправить лично\nОставьте пустым для отправки всем"
    whom = STDIN.gets.chomp
    message = Message.create(user: user, text: text, whom: whom)
    message.id ? next : user_choice = nil
    puts "Не введен текст или больше 100 символов\n"
  elsif user_choice == 2
    messages = Message.where(whom: [nil, ""])
    messages.each(&:to_s)
  elsif user_choice == 3
    messages = Message.where(whom: user.email)
    messages.each(&:to_s)
  end
end
