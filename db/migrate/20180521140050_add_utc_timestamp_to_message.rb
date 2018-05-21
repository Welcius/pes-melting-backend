class AddUtcTimestampToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :utc_timestamp, :integer
  end
end
