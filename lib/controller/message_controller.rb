class MessageController
  def initialize(all_user)
    @all_user = all_user
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
      @all_user.each { |user_member| MessagesUsers.create(user: user_member, message: message) }
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
end
