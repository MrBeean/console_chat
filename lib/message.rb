class Message
  attr_reader :name

  def initialize(data)
    @name = data["Name"]
    @text = data["Text"]
    @time = data["Time"]
    @whom = data["Whom"]
  end

  def to_s
    puts '___________________________________________'
    puts @text
    puts "(#{@time}) #{@name}"
    puts '___________________________________________'
  end
end
