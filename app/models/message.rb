class Message < ApplicationRecord
    belongs_to :chatroom
    belongs_to :user
    
    validates :body, :utc_timestamp, presence: true
end
