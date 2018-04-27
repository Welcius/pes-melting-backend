class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :update, :destroy]


  def index
    @votes = Vote.all
  end


  def show
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user
    if @vote.save
      render :show, status: :created, location: @vote
    else
      render json: @vote.errors, status: :unprocessable_entity
    end
  end


  def update
    if @vote.update(vote_params) and @vote.user_id != current_user
      render :show, status: :ok, location: @vote
    else
      render json: @vote.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vote.destroy
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
