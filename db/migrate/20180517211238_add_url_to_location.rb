class AddUrlToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :url, :string
  end
end
