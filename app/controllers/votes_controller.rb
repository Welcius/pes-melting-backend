module VotesHelper
   def same_user_as_current(user_id)
      return user_id == current_user.id 
   end
end


class VotesController < ApplicationController
 # before_action :set_vote, only: [:show, :update, :destroy]
  before_action :authenticate_user
  include UtilsModule
  include VotesHelper

  def index
    event = Event.find(params[:event_id])
    votes = event.votes.count
    render json: votes
  end


  def show
  end

  def new
    votes = Vote.new
    votes.user = current_user
    votes.event = Event.find(params[:event_id])
  end

  def create
    vote = Vote.new
    if(Vote.find_by(user_id: current_user.id, event_id: params[:event_id]).nil? and same_user_as_current(params[:user_id].to_i))  
      vote.user_id = current_user.id
      vote.event_id = (params[:event_id])
      if vote.save
        render json: vote, status: :created  
      else
        sendStatus("Error creating event", :conflict, vote.errors)
      end
    else
      sendStatus("Not more than 1 vote / user", :conflict, vote.errors)
    end
  end

  def destroy
    vote = Vote.find_by(params[:vote_id])
    if not vote.nil? and same_user_as_current(vote.user_id)
      vote.destroy
      render json: vote, status: :destroy
    else
      sendStatus("Current user != creator of the event or the user didnt voted", :conflict, vote.errors) 
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_vote
    #   vote = Vote.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_id, :event_id)
    end
end
