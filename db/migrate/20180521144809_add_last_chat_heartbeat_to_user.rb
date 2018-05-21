class AddLastChatHeartbeatToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_chat_heartbeat, :integer
  end
end
