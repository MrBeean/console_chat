class User < ActiveRecord::Base
  has_many :messages, dependent: :destroy

  validates :name,  length: { in: 3..20 }
  validates :email, :name, presence: true
end