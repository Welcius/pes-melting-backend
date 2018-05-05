require 'httparty'
require 'json'

class StaticInfo 
    include HTTParty
    
    base_uri "http://serveisoberts.gencat.cat"
    
    def info1
        self.class.get('/equipaments/search?rows=ALL&categories.tema=recerca&categories.subtema=Estructures%20universitaries&categories.subtema2=Universitats&adreca.municipi=Barcelona')
    end
    
    def info2
        def var 
             "UPC" 
        end
        self.class.get('/equipaments/search?rows=ALL&adreca.municipi=Barcelona&categories.subtema=Facultats%20i%20escoles&categories.tema=Universitats&nickname='+var)
    end   
    
    
    
    
end

satatic_info = StaticInfo.new
puts satatic_info.info2