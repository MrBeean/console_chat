require 'openssl'

# User отвечает за данные в таблице user
class User < ActiveRecord::Base
  has_many :messages, dependent: :destroy

  before_validation :downcase_userdata!

  validates :name,
            presence: { message: 'не может быть пустым' },
            length: { maximum: 20, message: 'не может быть больше 20 символов' }
  validates :email,
            presence: { message: 'не может быть пустым' },
            uniqueness: { message: 'должен быть уникальнымм' }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  attr_accessor :password

  def downcase_userdata!
    name.downcase!
    email.downcase!
  end
end
