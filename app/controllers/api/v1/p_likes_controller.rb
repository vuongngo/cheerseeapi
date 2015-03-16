class Api::V1::PLikesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
  	plink_like = PlinkLike.find(params[:plink_like_id])
  	p_like = plink_like.p_likes.build(p_like_params)
  	if p_like.save
      participation = Participation.find(plink_like.participation_id)
      participation.p_link_like[:count] = plink_like.p_likes.count
      participation.save

      user_id = participation.u[:u_id]
      msg = {
        user_id: user_id,
        resource: 'p_likes',
        action: 'create',
        element_id: p_like.id,
        u_id: p_like.u[:u_id],
        name: p_like.u[:name],
        avatar: p_like.u[:avatar],
        created_at: p_like.created_at
      }
      p_like[:pid] = params[:plink_like_id]
      $redis.publish 'participation-like', p_like.to_json
      if $redis.publish 'user-notification', msg.to_json
        UserNotification.create(msg)
      end
  	  render json: p_like, status: 201
  	else
  	  render json: { errors: p_like.errors }, status: 422
  	end
  end  

  def destroy
  	plink_like = PlinkLike.find(params[:plink_like_id])
  	p_like = plink_like.p_likes.find(params[:id])
  	if p_like[:u][:u_id] == current_user.id 
      p_like.destroy
      participation = Participation.find(plink_like.participation_id)
      participation.p_link_like[:count] = plink_like.p_likes.count
      participation.save
  	  head 204
  	end
  end

  private
    def p_like_params
      params.require(:p_like).permit(:created_at, :u => [:u_id, :name])
    end
end
