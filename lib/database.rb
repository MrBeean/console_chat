# DBConnection подключается пользователя к базе данных
class DBConnection
  def self.connect(environment)
    config_yml = File.join(File.expand_path(Dir.pwd), 'db', 'config.yml')
    db_configuration = YAML.safe_load(File.read(config_yml))
    ActiveRecord::Base.establish_connection(db_configuration[environment])
  end

  # TODO: этому тут не место, принцип единой обязанноссти
  def self.create_user(params)
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    user.save!
  rescue ActiveRecord::RecordInvalid => error_message
    puts error_message
    user
  end

  # TODO: этому тут не место, принцип единой обязанноссти
  def self.create_message(params)
    message = Message.create(
      user: params[:user],
      text: params[:text],
      whom: params[:whom]
    )
    message.save!
  rescue ActiveRecord::RecordInvalid => error_message
    puts error_message
    message
  end
end
