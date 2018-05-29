class Event < ApplicationRecord
    belongs_to :user
	has_many :comments, dependent: :destroy 
	has_many :votes, dependent: :destroy 
    belongs_to :location
    
    
    #search
    
    include PgSearch
    pg_search_scope :search, against: [:title]
    
end

