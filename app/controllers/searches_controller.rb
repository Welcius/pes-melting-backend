class SearchesController < ApplicationController
    def event 
        event = Event.where("title LIKE ? OR title LIKE ? OR title LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%")
        render json: event
    end

    def faculty
        faculty = Location.where("name LIKE ? OR name LIKE ? OR name LIKE ? OR alias LIKE ? AND type LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%", params[:query], "Faculty") 
        render json: faculty
    end
    
    def university
        university = Location.where("name LIKE ? OR name LIKE ? OR name LIKE ? OR alias LIKE ? AND type LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%","#{params[:query]}%", "University").where.not(alias: [nil, ""])
        render json: university
    end
    
    def profile
        profile = Profile.where("full_name LIKE ? OR full_name LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%").or.User.where("username LIKE ?")
        render json: profile
    end
    
    
    #fet -> substring, buscar per alias, majuscula
    #mira de buscar per username -> FALTA
    #####
    ###
    ####
    
    
    
    # def review
    #     review = Review.search(params[:query])
    #     render json: review
    # end

end
