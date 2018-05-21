class Chatroom < ApplicationRecord
    has_many :messages
    
    validates_associated :messages
    
    validates :name, presence: true
end
