require 'terminal-table'

# Message отвечает за данные в таблице message
class Message < ActiveRecord::Base
  belongs_to :user

  validates :text, :user, presence: true
  validates :text,
            length:
            {
              maximum: 100,
              message: 'не может быть больше 100 символов'
            }

  def to_s
    table = Terminal::Table.new(
      title: created_at.strftime('%Y.%m.%d %T'),
      rows: [[user.name], [text]],
      style: { width: 104 }
    )
    puts table
  end
end
