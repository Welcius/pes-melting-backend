require 'countries'

class Profile < ApplicationRecord
    belongs_to :user
    has_one :avatar, dependent: :destroy
    belongs_to :faculty
    
    # Comprova que el codi de païs compleixi amb l'estàndar ISO3166
    validates_presence_of :full_name
    validates_presence_of :country_code
    validates_presence_of :faculty_id
    validates :country_code, :inclusion => { in: ISO3166::Country.all.map {|c| c.alpha2}, :message => 'must be ISO3166-compliant' }
    validates_uniqueness_of :user_id
    validate :location_ref_must_be_a_faculty
    
    #search
    
    include PgSearch
    pg_search_scope :search, against: [:full_name]
    
    def country
       ISO3166::Country.find_country_by_alpha2(:country_code).name
    end
    
    private
    
    def location_ref_must_be_a_faculty
        if Faculty.find_by_id(faculty_id).nil?
            errors.add(:faculty, "must have a valid faculty ref")
        end
    end 
    
    # https://github.com/pyksoft/multi-photo-upload#multiple-photo-upload-using-shrine
end
