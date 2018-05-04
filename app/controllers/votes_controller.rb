class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :update, :destroy]
  before_action :authenticate_user
  include UtilsModule

  def index
    @event = Event.find(params[:event_id])
    @votes = @event.votes.count
  end


  def show
  end

  def new
    @votes = Vote.new
    @votes.user = current_user
    @votes.event = Event.find(params[:event_id])
  end

  def create
    vote = Vote.new(vote_params)
    vote.user = current_user
    vote.event = Event.find(params[:event_id])
    if vote.save
      render json: vote, status: :created  
    else
      sendStatus("Error creating event", :conflict, vote.errors)  
    end
  end


  def update
    if @vote.update(vote_params) and @vote.user_id != current_user
      render json: @vote
    else
      sendStatus("Error modifying vote", :conflict, @vote.errors)   
    end
  end

  def destroy
    @vote.destroy
    render json: @vote, status: :destroy   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_id, :event_id)
    end
end
