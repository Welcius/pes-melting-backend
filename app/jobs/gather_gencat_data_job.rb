require 'gencat'

class GatherGencatDataJob < ApplicationJob
  queue_as :default

  def perform
    puts "Gathering universities and faculties data..."
    g = Gencat.new
    universities = g.list_of_universities
    for uni in universities
      if University.find_by_alias(uni['alias']).nil?
        University.create(:name => uni['name'], :alias => uni['alias'], :latitude => uni['latitude'], :longitude => uni['longitude'], :address => uni['address'], :url => uni['url'], :telephone => uni['telephone'])
      end
    end
    faculties = g.list_of_faculties
    for fac in faculties
      uni_alias = fac['name'][/\(.*?\)/][1..-2]
      u = University.find_by_alias(uni_alias)
      if not u.nil?
        Faculty.create(:name => fac['name'], :latitude => fac['latitude'], :longitude => fac['longitude'], :address => fac['address'], :url => fac['url'], :telephone => fac['telephone'], :university_id => u.id)
      end
    end
    puts "Gathering finished"
  end
end