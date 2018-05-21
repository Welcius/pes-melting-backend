class AddNameToChatroom < ActiveRecord::Migration[5.1]
  def change
    add_column :chatrooms, :name, :string
  end
end
