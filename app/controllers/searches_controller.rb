class SearchesController < ApplicationController
    def event 
        event = Event.where("title LIKE ? OR title LIKE ? OR title LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%")
        render json: event
    end

    def faculty
        faculty = Faculty.where("name LIKE ? OR name LIKE ? OR name LIKE ? OR alias LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%", params[:query]) 
        render json: faculty
    end
    
    def university
        university = University.where("name LIKE ? OR name LIKE ? OR name LIKE ? OR alias LIKE ? ", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%","#{params[:query]}%")
        render json: university
    end
    
    def profile
        profile = Profile.joins(:user).where("username LIKE ? OR username LIKE ? OR username LIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%")
        render json: profile
    end

    
    # def review
    #     review = Review.search(params[:query])
    #     render json: review
    # end

end
