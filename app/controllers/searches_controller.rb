class SearchesController < ApplicationController
    def event 
        event = Event.where("title ILIKE ? OR title ILIKE ? OR title ILIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%")
        render json: event
    end

    def faculty
        faculty = Faculty.where("name ILIKE ? OR name ILIKE ? OR name ILIKE ? OR alias ILIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%", params[:query]) 
        render json: faculty
    end
    
    def university
        university = University.where("name ILIKE ? OR name ILIKE ? OR name ILIKE ? OR alias ILIKE ? ", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%","#{params[:query]}%")
        render json: university
    end
    
    def profile
        profile = Profile.joins(:user).where("username ILIKE ? OR username ILIKE ? OR username ILIKE ?", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%")
        render json: profile
    end

    
    # def review
    #     review = Review.search(params[:query])
    #     render json: review
    # end

end
