class Message < ActiveRecord::Base
  belongs_to :user

  validates :text, :user, presence: true
  validates :text, length: { maximum: 100 }
end