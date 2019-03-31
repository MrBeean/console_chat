# DBConnection подключает пользователя к базе данных
class DBConnection
  def self.connect(environment)
    config_yml = File.join(File.expand_path(Dir.pwd), 'db', 'config.yml')
    db_configuration = YAML.safe_load(File.read(config_yml))
    ActiveRecord::Base.establish_connection(db_configuration[environment])
  end
end
