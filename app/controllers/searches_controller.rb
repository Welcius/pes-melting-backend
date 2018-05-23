class SearchesController < ApplicationController
    def event 
        event = Event.where("title ILIKE ? OR title ILIKE ? OR title ILIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%") 
        render json: event
    end
    
    def university
        university = Location.where("name ILIKE ? OR name ILIKE ? OR name ILIKE ? OR alias ILIKE ? OR AND type ILIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%", params[:query], "University")
        render json: university
    end
    
    def profile
        profile = Profile.where("full_name ILIKE ? OR full_name ILIKE ? OR full_name ILIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%") 
        render json: profile
    end
    
    #fet -> substring, buscar per alias, majuscula funciona?
    #mira de buscar per username
    #####
    ###
    ####
    
    def faculty
        faculty = Location.where("name ILIKE ? OR name ILIKE ? OR name ILIKE ? OR alias ILIKE ? AND type ILIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%", params[:query], "Faculty") 
        render json: faculty
    end
    
    # def review
    #     review = Review.search(params[:query])
    #     render json: review
    # end

end
