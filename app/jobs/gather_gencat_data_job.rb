require 'gencat'

class GatherGencatDataJob < ApplicationJob
  queue_as :default

  def perform
    g = Gencat.new
    universities = g.list_of_universities
    for uni in universities
      if University.find_by_alias(uni['alias']).nil?
        University.create(:name => uni['name'], :alias => uni['alias'], :latitude => uni['latitude'], :longitude => uni['longitude'], :address => uni['address'], :telephone => uni['telephone'])
      end
    end
    faculties = g.list_of_faculties
    for fac in faculties
      uni_alias = fac['name'][/\(.*?\)/][1..-2]
      u = University.find_by_alias(uni_alias)
      if not u.nil?
        f = Faculty.create(:name => fac['name'], :latitude => fac['latitude'], :longitude => fac['longitude'], :address => fac['address'], :telephone => fac['telephone'], :university_id => u.id)
      else
        puts uni_alias
      end
    end
  end
end