class CreateMessagesUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :messages_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :message, index: true
      t.boolean :read, default: false
    end
  end
end
