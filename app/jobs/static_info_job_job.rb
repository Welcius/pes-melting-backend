class StaticInfoJobJob < ApplicationJob
  require 'httparty'
  require 'json'
  include HTTParty
  queue_as :default

#universidades y su info


class StaticInfo 
    include HTTParty
    
    base_uri "http://serveisoberts.gencat.cat"
    
    def info1
          
        self.class.get('/equipaments/search?rows=ALL&categories.tema=recerca&categories.subtema=Estructures%20universitaries&categories.subtema2=Universitats&adreca.municipi=Barcelona')
    end
    
    def info2(var)
      
        self.class.get('/equipaments/search?rows=ALL&adreca.municipi=Barcelona&categories.subtema=Facultats%20i%20escoles&categories.tema=Universitats&nickname='+var)
    end   
end

  def perform(*args)
      
       def satatic_info 
       StaticInfo.new
   end  
   
   
   
   body = JSON.parse(satatic_info.info1.body)

#universidades y su info
 universidades_json = []
 facultades_json = []

body["items"].each do |doc|
    universidades_json << doc["id"].to_json
    universidades_json << doc["nickname"].to_json
    universidades_json << doc["titol"].to_json
    universidades_json << doc["adreca"].to_json
    universidades_json << doc["url"].to_json
    universidades_json << doc["telefons"].to_json
    universidades_json << doc["fax"].to_json
    universidades_json << doc["geolocalitzacio"].to_json

    body2 = JSON.parse(satatic_info.info2(doc["nickname"]).body)  
    
    body2["items"].each do |doc2|
    
    facultades_json << doc2["id"].to_json
    facultades_json << doc2["titol"].to_json
    facultades_json << doc2["adreca"].to_json
    facultades_json << doc2["telefons"].to_json
    facultades_json << doc2["telefons"].to_json
    
    puts facultades_json

 end

    
   # puts universidades_json
end
    
    puts "hola"
end

