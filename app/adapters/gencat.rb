require 'gencat_service'

class Gencat
    
    public
    
    def initialize
        g = GencatService.new
        @@universities = g.getUniversities
        @@faculties = g.getFaculties
    end
    
    def list_of_universities
        res = []
        for uni in @@universities['items']
            res << {'title' => uni['titol'], 
                    'alias' => uni['nickname'], 
                    'url' => uni['url'], 
                    'address' => uni['adreca']['carrer'],
                    'telephone' => uni['telefons'][0].delete(' '),
                    'latitude' => uni['geolocalitzacio']['latitud'], 
                    'longitude' => uni['geolocalitzacio']['longitud']}
        end
        res
    end
    
    def list_of_faculties
        res = []
        for fac in @@faculties['items']
            res << {'title' => fac['titol'], 
                    'alias' => fac['nickname'], 
                    'url' => fac['url'], 
                    'address' => fac['adreca']['carrer'],
                    'telephone' => fac['telefons'][0].delete(' '),
                    'latitude' => fac['geolocalitzacio']['latitud'], 
                    'longitude' => fac['geolocalitzacio']['longitud']}
        end
        res
    end
    
end