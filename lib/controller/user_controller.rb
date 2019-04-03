class UserController
  def self.create_user(params)
    user = User.new(
        name: params[:name],
        email: params[:email],
        password: params[:password]
    )
    user.save!
  rescue ActiveRecord::RecordInvalid => error_message
    puts error_message
  end
end
