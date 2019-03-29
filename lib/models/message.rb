require 'terminal-table'

class Message < ActiveRecord::Base
  belongs_to :user

  validates :text, :user, presence: true
  validates :text, length: { maximum: 100 }

  def to_s
    table = Terminal::Table.new(
      title:self.created_at.strftime('%Y.%m.%d %T'),
      rows: [[self.user.name],[self.text]],
      style: { :width => 104 }
    )
    puts table
  end
end
