# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#upc = University.create(:name => 'Universitat Politècnica de Catalunya', :latitude => 41.38808167268847, :longitude => 2.115467640261582)
#fib = Faculty.create(:name => 'Facultat d\' Informàtica de Barcelona', :latitude => 41.3894841, :longitude => 2.1133859000000257, :university => upc)
#etseib = Faculty.create(:name => 'Escola Tècnica Superior d\'Enginyeria Industrial de Barcelona', :latitude => 41.38479239999999, :longitude => 2.11563799999999, :university => upc)
#
#ub = University.create(:name => 'Universitat de Barcelona', :latitude => 41.386815602994155, :longitude => 2.164813254538371)
#ubquim = Faculty.create(:name => 'Facultat de Química', :latitude => 41.3852079, :longitude => 2.1177860999999893, :university => ub)
#ubfis = Faculty.create(:name => 'Facultat de Física', :latitude => 41.3844004, :longitude => 2.1171888999999737, :university => ub)

User.create(:email => "alex.cmillan@outlook.com", :username => "alexcmillan", :password => "12345678", :code => 'abcdef', :last_status => 0, :activated => true)
User.create(:email => "laufipe@gmail.com", :username => "laufipe", :password => "12345678", :code => 'abcdef', :last_status => 0, :activated => true)
User.create(:email => "adolfoo.bcn@gmail.com", :username => "adolfo", :password => "12345678", :code => 'abcdef', :last_status => 0, :activated => true)
User.create(:email => "carlavareap14@gmail.com", :username => "carlavarea", :password => "12345678", :code => 'abcdef', :last_status => 0, :activated => true)
User.create(:email => "uapllenobrac@gmail.com", :username => "paucarbonell", :password => "12345678", :code => 'abcdef', :last_status => 0, :activated => true)
User.create(:email => "ismael.aik@gmail.com", :username => "ismael", :password => "12345678", :code => 'abcdef', :last_status => 0, :activated => true)

GatherGencatDataJob.perform_now