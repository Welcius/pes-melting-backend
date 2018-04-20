require 'countries'

class Profile < ApplicationRecord
    # Comprova que el codi de païs compleixi amb l'estàndar ISO3166
    validates :country_code, :inclusion => { in: ISO3166::Country.all.map {|c| c.alpha2}, :message => 'Country code must be ISO3166-compliant' }
    
    def country
       ISO3166::Country.find_country_by_alpha2(:country_code).name
    end
end
