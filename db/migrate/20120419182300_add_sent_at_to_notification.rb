class AddSentAtToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :sent_at, :datetime
    add_index :notifications, :sent_at
  end
end
