require 'bcrypt'

# User отвечает за данные в таблице user
class User < ActiveRecord::Base
  include BCrypt

  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :messages

  before_validation :downcase_userdata!

  validates :name,
            presence: true,
            length: { maximum: 20, message: 'не может быть больше 20 символов' }
  validates :email,
            presence: true,
            uniqueness: { message: 'должен быть уникальнымм' }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  attr_accessor :password

  validates_presence_of :password, on: :create
  before_save :encrypt_password

  def encrypt_password
    self.password_hash = BCrypt::Password.create(password) if password.present?
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    return user if BCrypt::Password.new(user.password_hash) == password

    nil
  end

  def downcase_userdata!
    name.downcase!
    email.downcase!
  end
end
