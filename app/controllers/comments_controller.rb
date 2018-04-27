class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :authenticate_user

  def index
    @comments = Comment.all
  end


  def show
  end


  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save and !@comment.content.nil?
      render :show, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end


  def update 
    if @comment.user_id != current_user
    else 
      if @comment.update(comment_params) and !@comment.content.nil?
        render :show, status: :ok, location: @comment
      else
      render json: @comment.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @comment.user_id != current_user
    end
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :event_id, :user_id)
    end
end
