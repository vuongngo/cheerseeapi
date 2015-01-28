class Api::V1::CCommentsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
  	contest = Contest.find(params[:contest_id])
  	c_comment = contest.c_comments.build(c_comment_params)
  	if c_comment.save
  	  render json: c_comment, status: 201
  	else
  	  render json: { errors: c_comment.errors }, status: 422
  	end
  end

  def update
  	contest = Contest.find(params[:contest_id])
  	c_comment = contest.c_comments.find(params[:id])
  	if c_comment.update_attributes(c_comment_params) && c_comment.u[:u_id] == current_user.id
  	  render json: c_comment, status: 200
  	else
      render json: { errors: c_comment.errors }, status: 422
    end
  end

  def destroy
  	contest = Contest.find(params[:contest_id])
  	c_comment = contest.c_comments.find(params[:id])
  	if c_comment.u[:u_id] == current_user.id
  	  c_comment.delete
  	  head 204
  	end
  end

  private
    def c_comment_params
      params.require(:c_comment).permit(:post, :created_at, :u => [:u_id, :name])
    end

end
