class LocationsController < ApplicationController
    include UtilsModule
    
    before_action :authenticate_user
    
    def index
        if params[:type] == 'Faculty'
            uni = University.find_by_id(params[:university_id])
            if uni.nil?
                sendStatus("University doesn't exist", :not_found)
            else
                render json: Location.where(:type => params[:type], :university_id => uni.id)
            end
        else
            render json: Location.where(:type => params[:type])
        end
    end
    
    
       
    
    after_initialize do 
     #get data from Api to store in DB
    University_struct = Struct.new( :id, :name, :nickname, :address, :url, :telephone, :fax, :longitude,:latitude )
    Faculty_struct= Struct.new( :id, :name, :nickname, :address, :url, :telephone, :fax, :longitude, :latitude )
    
     obj1 = University_struct.new()
     obj2 = Faculty_struct.new()
    ServiceStaticInfoJob.set(wait: 1.month).perform_later(obj1,obj2) #falta  poner tiempo y hacerlo background
    
    
    if(obj1!=nil and obj2 != nil)
        #store data
        obj1.each do
            university = University.new(:latitude => params[obj1.latitude], :longitude => params[obj1.longitude], :address => params[obj1.address], :name => params[obj1.name],
                                        :telephone => params[obj1.telephone], :fax => params[obj1.fax], :url => params[obj1.url], :nickname => params[obj1.nickname])
            university.save
            puts university
        end
        
        obj2.each do
            faculty = Faculty.new(:latitude => params[ obj2.latitude ], :longitude => params[ obj2.longitude], :address => params[obj2.address],
                                    :telephone => params[obj2.telephone ], :fax => params[obj2.fax], :url => params[obj2.url], :nickname => params[obj2.nickname])
            faculty.save
        end    
        
    end
    end
    
    
    






    def showFacultyInfo
        u = User.find_by_id(params[user_id])
       
        if u.nil?
            sendStatus("User does not exist", :not_found)
        else
            if u.profile.faculty_id.nil?
                sendStatus("Faculty does not exist", :not_found)
             else    
                fac = Faculty.find_by_id(u.profile.faculty_id)
                render  json :fac
            end
        end
    
    end
    
    
   def showFacultyInfo
        u = User.find_by_id(params[user_id])
       
        if u.nil?
            sendStatus("User does not exist", :not_found)
        else
            if u.profile.faculty_id.nil?
                sendStatus("Faculty does not exist", :not_found)
             else    
                fac = Faculty.find_by_id(u.profile.faculty_id)
                render  json :fac
            end
        end
    
end    