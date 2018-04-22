class CreateUniversities < ActiveRecord::Migration[5.1]
  def change
    create_table :universities do |t|

      t.timestamps
    end
  end
end
