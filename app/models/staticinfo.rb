require 'httparty'
require 'json'

class StaticInfo 
    include HTTParty
    base_uri "https://serveisoberts.gencat.cat"
    
    def info1
        self.class.get('/equipaments/search?rows=ALL&categories.tema=Recerca&categories.subtema=Estructures%20universitàries&categories.subtema2=Universitats&adreca.municipi=Barcelona')
    end
end

satatic_info = StaticInfo.new
puts satatic_info.info1