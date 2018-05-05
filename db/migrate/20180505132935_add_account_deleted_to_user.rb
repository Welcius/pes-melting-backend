class AddAccountDeletedToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :account_deleted, :boolean, :default => false
  end
end
