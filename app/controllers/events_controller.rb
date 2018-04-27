class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :authenticate_user

  def index
    @events = Event.all
  end


  def show
  end


  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if !Event.find_by_title(params[:title]).nil? || @event.title.nil? || @event.description.nil?
       render json: @event.errors, status: :unprocessable_entity 
    else
      if @event.save
        render :show, status: :created, location: @event
      else
      render json: @event.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    if @event.user != current_user
      #render json: @event.errors, status: :unprocessable_entity
    else
      if @event.update(event_params) and !@event.title.nil? and !@event.description.nil?
     # render :show, status: :ok, location: @event
      else
      #render json: @event.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @event.user_id == current_
       @event.destroy
    else
       #render json: @event.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:event_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :user_id)
    end
end
