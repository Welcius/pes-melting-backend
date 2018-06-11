class AddResetHashToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reset_hash, :string, default: nil
  end
end
