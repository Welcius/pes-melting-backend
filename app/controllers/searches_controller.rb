class SearchesController < ApplicationController
    def event
        event = Event.where("title LIKE ? OR title LIKE ? OR title LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%") 
        render json: event
    end
    
    def university
        university = Location.where("name LIKE ? OR name LIKE ? OR name LIKE ? OR alias LIKE ? OR AND type LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%", params[:query], "University")
        render json: university
    end
    
    def profile
        profile = Profile.where("full_name LIKE ? OR full_name LIKE ? OR full_name LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%") 
        render json: profile
    end
    
    #fet -> substring, buscar per alias, majuscula funciona?
    #mira de buscar per username
    #####
    ###
    ####
    
    def faculty
        faculty = Location.where("name LIKE ? OR name LIKE ? OR name LIKE ? OR alias LIKE ? AND type LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%", params[:query], "Faculty") 
        render json: faculty
    end
    
    # def review
    #     review = Review.search(params[:query])
    #     render json: review
    # end

end
