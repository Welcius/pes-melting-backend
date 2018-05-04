class Event < ApplicationRecord
    belongs_to :user, optional: true
	has_many :comments
	has_many :votes
    belongs_to :location
    
end

