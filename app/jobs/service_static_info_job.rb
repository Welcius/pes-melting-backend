class ServiceStaticInfoJob < ApplicationJob
  queue_as :default
  
  class StaticInfo 
    require 'httparty'
    require 'json'
    include HTTParty
    base_uri "http://serveisoberts.gencat.cat"
    
    def info1
        self.class.get('/equipaments/search?rows=ALL&categories.tema=recerca&categories.subtema=Estructures%20universitaries&categories.subtema2=Universitats&adreca.municipi=Barcelona')
    end
    
    def info2(var)
       self.class.get('/equipaments/search?rows=ALL&adreca.municipi=Barcelona&categories.subtema=Facultats%20i%20escoles&categories.tema=Universitats&nickname='+var)
    end   
  end
  
   
  def perform(obj1,obj2)
    
    static_info =  StaticInfo.new
    body = JSON.parse(static_info.info1.body)
     
    body["items"].each do |doc|
      obj1.id = doc["id"].to_json
      obj1.name = doc["titol"].to_json
      obj1.nickname = doc["nickname"].to_json
      obj1.address = doc["adreca"].to_json
      obj1.url = doc["url"].to_json
      obj1.telephone = doc["telefons"].to_json
      obj1.fax = doc["fax"].to_json
      geolocalization1 = doc["geolocalitzacio"]
      obj1.longitude = geolocalization1["longitud"].to_json
      obj1.latitude = geolocalization1["latitud"].to_json

      body2 = JSON.parse(static_info.info2(doc["nickname"]).body)  
      
      body2["items"].each do |doc2|
    
        obj2.id = doc2["id"].to_json
        obj2.name = doc2["titol"].to_json
        obj2.nickname = doc["nickname"].to_json
        obj2.address = doc2["adreca"].to_json
        obj2.url = doc2["url"]
        obj2.telephone = doc2["telefons"].to_json
        obj2.fax = doc2["fax"].to_json
        geolocalization = doc2["geolocalitzacio"]
        obj2.longitude = geolocalization["longitud"].to_json
        obj2.latitude = geolocalization["latitud"].to_json
      end
    end
  end
end
