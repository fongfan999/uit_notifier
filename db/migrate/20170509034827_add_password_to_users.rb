class AddPasswordToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :encrypted_password, :string
  end
end
