class AddNicknameToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :nickname, :string
  end
end
