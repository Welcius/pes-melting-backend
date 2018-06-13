class SearchesController < ApplicationController
    def event 
        event = Event.where("unaccent(title) ILIKE unaccent(?) OR unaccent(title) ILIKE unaccent(?) OR unaccent(title) ILIKE unaccent(?)", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%")
        render json: event
    end

    def faculty
        faculty = Faculty.where("unaccent(name) ILIKE unaccent(?) OR unaccent(name) ILIKE unaccent(?) OR unaccent(name) ILIKE unaccent(?) OR unaccent(alias) ILIKE unaccent(?)", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%", params[:query]) 
        render json: faculty
    end
    
    def university
        university = University.where("unaccent(name) ILIKE unaccent(?) OR unaccent(name) ILIKE unaccent(?) OR unaccent(name) ILIKE unaccent(?) OR unaccent(alias) ILIKE unaccent(?) ", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%","#{params[:query]}%")
        render json: university
    end
    
    def profile
        profile = Profile.joins(:user).where("NOT account_deleted AND (unaccent(username) ILIKE unaccent(?) OR unaccent(username) ILIKE unaccent(?) OR unaccent(username) ILIKE unaccent(?))", "#{params[:query]}%", "% #{params[:query]}%", "%#{params[:query]}%")
        render json: profile
    end



end
