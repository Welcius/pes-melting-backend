class AddAliasToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :alias, :string
  end
end
