class AddFaxToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :fax, :string
  end
end
