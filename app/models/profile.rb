require 'countries'

class Profile < ApplicationRecord
    has_one :avatar, dependent: :destroy
    
    # Comprova que el codi de païs compleixi amb l'estàndar ISO3166
    validates :country_code, :inclusion => { in: ISO3166::Country.all.map {|c| c.alpha2}, :message => 'Country code must be ISO3166-compliant' }
    
    def country
       ISO3166::Country.find_country_by_alpha2(:country_code).name
    end
    
    # https://github.com/pyksoft/multi-photo-upload#multiple-photo-upload-using-shrine
end
