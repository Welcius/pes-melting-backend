class SearchesController < ApplicationController
    def event 
        event = Event.where("title ILIKE ? OR title ILIKE ? OR title ILIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%") 
        render json: event
    end
    
    def university
        university = Location.where("name ILIKE ? OR name ILIKE ? OR name ILIKE ? OR alias ILIKE ? OR AND type ILIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%","#{params[:query]}%", "University")
        render json: university
    end
    
    def profile
        profile = Profile.where("full_name ILIKE ? OR full_name ILIKE ? OR full_name ILIKE ? OR user_id ILIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%", (User.find_by(username: params[:query])).user_id) 
        render json: profile
    end
    
    
    #fet -> substring, buscar per alias, majuscula
    #mira de buscar per username -> FALTA
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
