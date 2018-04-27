class AddCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :code, :string, :null => false, :default => ''
  end
end
