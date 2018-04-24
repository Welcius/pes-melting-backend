class Faculty < Location
    belongs_to :university
    validates :university_id, presence: { message: "University ref must exist" }
end
