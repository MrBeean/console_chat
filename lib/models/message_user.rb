class MessagesUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  validates :read, inclusion: { in: [true, false] }
end