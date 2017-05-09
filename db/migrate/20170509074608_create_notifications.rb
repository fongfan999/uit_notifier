class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :content
      t.string :link

      t.timestamps
    end
  end
end
