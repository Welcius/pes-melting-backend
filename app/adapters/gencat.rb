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
            tmp_tel = uni['telefons'][0].delete(' ')
            res << {'name' => uni['titol'], 
                    'alias' => uni['nickname'], 
                    'url' => uni['url'], 
                    'address' => uni['adreca']['carrer'],
                    'telephone' => if tmp_tel.length > 0 then tmp_tel else nil end,
                    'latitude' => uni['geolocalitzacio']['latitud'], 
                    'longitude' => uni['geolocalitzacio']['longitud']}
        end
        res
    end
    
    def list_of_faculties
        res = []
        for fac in @@faculties['items']
            tmp_tel = fac['telefons'][0].delete(' ')
            res << {'name' => fac['titol'], 
                    'alias' => fac['nickname'], 
                    'url' => fac['url'], 
                    'address' => fac['adreca']['carrer'],
                    'telephone' => if tmp_tel.length > 0 then tmp_tel else nil end,
                    'latitude' => fac['geolocalitzacio']['latitud'], 
                    'longitude' => fac['geolocalitzacio']['longitud']}
        end
        res
    end
    
end