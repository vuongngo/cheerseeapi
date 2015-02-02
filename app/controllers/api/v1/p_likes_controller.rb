class Api::V1::PLikesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
  	plink_like = PlinkLike.find(params[:plink_like_id])
  	p_like = plink_like.p_likes.build(p_like_params)
  	if p_like.save
      participation = Participation.find(plink_like.participation_id)
      participation.p_link_like[:count] =+ 1
      participation.save
  	  render json: p_like, status: 201
  	else
  	  render json: { errors: p_like.errors }, status: 422
  	end
  end  

  def destroy
  	plink_like = PlinkLike.find(params[:plink_like_id])
  	p_like = plink_like.p_likes.find(params[:id])
  	if p_like[:u][:u_id] == current_user.id 
      participation = Participation.find(plink_like.participation_id)
      participation.p_link_like[:count] =- 1
      participation.save
  	  p_like.destroy
  	  head 204
  	end
  end

  private
    def p_like_params
      params.require(:p_like).permit(:created_at, :u => [:u_id, :name])
    end
end
