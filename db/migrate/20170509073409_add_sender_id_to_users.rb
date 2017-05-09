class AddSenderIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sender_id, :string
  end
end
