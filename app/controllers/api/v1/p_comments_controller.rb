class Api::V1::PCommentsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
  	plink_comment = PlinkComment.find(params[:plink_comment_id])
  	p_comment = plink_comment.p_comments.build(p_comment_params)
  	if p_comment.save
      participation = Participation.find(plink_comment.participation_id)
      participation.p_link_comment[:count] =+ 1
      participation.save
  	  render json: p_comment, status: 201
  	else
  	  render json: { errors: p_comment.errors }, status: 422
  	end
  end

  def update
  	plink_comment = PlinkComment.find(params[:plink_comment_id])
  	p_comment = plink_comment.p_comments.find(params[:id])
  	if p_comment.update_attributes(p_comment_params) && p_comment[:u][:u_id] == current_user.id
  	  render json: p_comment, status: 200
  	else
  	  render json: { errors: p_comment.errors}, status: 422
  	end
  end

  def destroy
  	plink_comment = PlinkComment.find(params[:plink_comment_id])
	  p_comment = plink_comment.p_comments.find(params[:id])
	  if p_comment[:u][:u_id] == current_user.id
      participation = Participation.find(plink_comment.participation_id)
      participation.p_link_comment[:count] =- 1
      participation.save	  
      p_comment.destroy
	    head 204
	  end
  end

  private
    def p_comment_params
      params.require(:p_comment).permit(:post, :created_at, :u => [:u_id, :name] )
    end
end
