class AddEncryptedPasswordIvToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :encrypted_password_iv, :string
  end
end
