class Faculty < Location
    belongs_to :university
    validates :university_id, presence: { message: "must reference an existing university" }
    validate :location_ref_must_be_an_university
   
    #search
    
    include PgSearch
    pg_search_scope :search, against: [:name]
    
    private
    
    def location_ref_must_be_an_university
        if University.find_by_id(university_id).nil?
            errors.add(:university, "must have a valid university ref")
        end
    end 
end
