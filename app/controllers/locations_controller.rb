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
end
