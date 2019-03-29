class User < ActiveRecord::Base
  has_many :messages, dependent: :destroy

  before_validation :userdata_downcase!

  validates :name, presence: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true

  def userdata_downcase!
    self.name.downcase!
    self.email.downcase!
  end
end