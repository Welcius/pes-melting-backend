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
    event = Event.find_by_id(params[:event_id].to_i)
    if not event.nil?
      votes = event.votes.count
      render json: votes
    else
      sendStatus("Event doesn't exist")
    end
  end


  def show
    event = Event.find_by_id(params[:event_id].to_i)
    if not event.nil?
      vote = event.votes.find_by_user_id(current_user.id)
      if not vote.nil?
        render json: vote
      else
        sendStatus("User has not voted", :not_found)
      end
    else
      sendStatus("Event doesn't exist", :not_found)
    end
  end

  def new
    votes = Vote.new
    votes.user = current_user
    votes.event = Event.find(params[:event_id])
  end

  def create
    vote = Vote.new
    event = Event.find_by_id(params[:event_id].to_i)
    if not event.nil?
      if Vote.find_by(user_id: current_user.id, event_id: params[:event_id].to_i).nil?
        vote.user_id = current_user.id
        vote.event_id = (params[:event_id]).to_i
        if vote.save
          if not current_user.profile.nil? 
            current_user.profile.add_karma(5)
          end
          uid = Event.find_by_id(params[:event_id].to_i).user_id
          user = User.find_by_id(uid)
          user.profile.add_karma(1)
          render json: vote, status: :created  
        else
          sendStatus("Error creating event", :conflict, vote.errors)
        end
      else
        sendStatus("Not more than 1 vote / user", :conflict, vote.errors)
      end
    else
      sendStatus("Event doesn't exist", :not_found)
    end
  end

  def destroy
    event = Event.find_by_id(params[:event_id].to_i)
    if not event.nil?
      vote = Vote.find_by(user_id: current_user.id, event_id: params[:event_id].to_i)
      if not vote.nil?
        if same_user_as_current(vote.user_id)
          vote.destroy
          current_user.profile.add_karma(-5)
          uid = Event.find_by_id(params[:event_id].to_i).user_id
          user = User.find_by_id(uid)
          user.profile.add_karma(-1)
          sendStatus("Vote erased", :ok)
        else
          sendStatus("Current user != creator of the event", :unauthorized) 
        end
      else
        sendStatus("Vote not found", :not_found)
      end
    else
      sendStatus("Event doesn't exist", :not_found)
    end
  end
  
  # def assist
  #   if !(Vote.find_by(user_id: current_user.id, event_id: params[:event_id])).nil?
  #     render json: 1
  #   else 
  #     render json: 0
  #   end
  # end
  
  # def assistants
  #   event = Event.find(params[:event_id])
  #   votes = event.votes
  #   render json: votes, :only=>  [:user_id]
  # end


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
