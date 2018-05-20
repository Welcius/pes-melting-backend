class AddTelephoneToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :telephone, :string
  end
end
