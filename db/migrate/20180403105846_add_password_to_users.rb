class AddPasswordToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string, :null => false, :default => ''
  end
end
