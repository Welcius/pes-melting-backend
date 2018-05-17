require 'rest-client'
require 'uri'

class GencatService
    private
    BASE_URL = 'http://serveisoberts.gencat.cat'
    
    public
    def getUniversities
        response = RestClient.get(BASE_URL + '/equipaments/search',
                                 :params => {'rows' => 'ALL',
                                             'adreca.municipi' => 'Barcelona',
                                             'categories.tema' => 'Recerca',
                                             'categories.subtema' => 'Estructures universitàries',
                                             'categories.subtema2' => 'Universitats'
                                             })
        data = JSON.parse(response)
    end
    
    def getFaculties
        response = RestClient.get(BASE_URL + '/equipaments/search',
                                 :params => {'rows' => 'ALL',
                                             'adreca.municipi' => 'Barcelona',
                                             'categories.tema' => 'Universitats',
                                             'categories.subtema' => 'Facultats i escoles'
                                             })
        data = JSON.parse(response)
    end
end