class Event < ApplicationRecord
    belongs_to :user, optional: true
	has_many :comments
	has_many :votes
    has_one :location
    
end

