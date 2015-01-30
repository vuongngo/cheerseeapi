class Api::V1::CLikesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
  	clink_like = ClinkLike.find(params[:clink_like_id])
  	c_like = clink_like.c_likes.build(c_like_params)
  	if c_like.save
  	  render json: c_like, status: 201
  	else
  	  render json: { errors: c_like.errors }, status: 422
  	end
  end  

  def destroy
  	clink_like = ClinkLike.find(params[:clink_like_id])
  	c_like = clink_like.c_likes.find(params[:id])
  	if c_like[:u][:u_id] == current_user.id 
  	  c_like.destroy
  	  head 204
  	end
  end

  private
    def c_like_params
      params.require(:c_like).permit(:created_at, :u => [:u_id, :name])
    end
end
