class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :url
      t.string :method, :default => 'get'
      t.string :params
      t.string :content_type, :default => 'application/xml'
      t.string :periodicity, :default => 'daily'

      t.timestamps
    end
  end
end
