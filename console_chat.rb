require 'active_record'

require_relative 'lib/models/user'
require_relative 'lib/models/message'
require_relative 'lib/models/message_user'
require_relative 'lib/database'

DBConnection.connect('development')

def self.cls
  system('cls') || system('clear')
end

def create_user(params)
  user = User.new(
    name: params[:name],
    email: params[:email],
    password: params[:password]
  )
  user.save!
rescue ActiveRecord::RecordInvalid => error_message
  puts error_message
end

def create_message(params)
  message = Message.new(
    user: params[:user],
    text: params[:text]
  )
  begin
    message.save!
  rescue ActiveRecord::RecordInvalid => error_message
    puts error_message
  end
  return nil if message.id.nil?

  if params[:whom].empty?
    User.all.each { |user_member| MessagesUsers.create(user: user_member, message: message) }
  else
    whom = User.find_by(email: params[:whom])
    if whom
      MessagesUsers.create(user: whom, message: message)
    else
      puts "Сообщение не отправлено, такого пользователя #{whom} нет"
    end
  end
  message
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
    puts "Введите ваш пароль\n\n"
    params[:password] = STDIN.gets.chomp
    create_user(params)
    user = User.find_by(email: params[:email])
    user ? next : user_choice = nil
  elsif user_choice == 2
    puts 'Введите ваш email'
    email = STDIN.gets.chomp
    puts "Введите ваш пароль\n\n"
    password = STDIN.gets.chomp
    user = User.authenticate(email, password)
    user ? next : user_choice = nil
    puts 'Вы ошиблись в email/пароле'
  end
end

while user_choice != 9
  puts '--------------'
  puts "Всего вам адресованно #{MessagesUsers.where(user: user).count} сообщений"
  puts 'Не прочитанных сообщений - ' + MessagesUsers.where(user: user).where(read: false).count.to_s
  puts '--------------'
  puts "\nВыберите действие:\n"
  puts "написать сообщение - 1\nпрочитать сообщения, адресованные мне - 2"
  puts "прочитать написанные мной сообщения - 3\nвыход - 9"

  user_choice = STDIN.gets.chomp.to_i
  if user_choice == 1
    params = {}
    puts 'Введите текст сообщения !! Не более 100 символов!!'
    params[:text] = STDIN.gets.chomp
    puts "Напишите email кому хотите отправить лично\n(Оставьте пустым для отправки всем)"
    params[:whom] = STDIN.gets.chomp
    params[:user] = user
    message = create_message(params)
    message ? next : user_choice = nil
  elsif user_choice == 2
    MessagesUsers.where(user: user).where(read: false).each do |relation|
      relation.message.to_s
      relation.read = true
      relation.save!
    end
  elsif user_choice == 3
    messages = Message.where(user_id: user.id)
    messages.each(&:to_s)
  end
end
