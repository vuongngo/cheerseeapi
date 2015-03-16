class Api::V1::CLikesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
  	clink_like = ClinkLike.find(params[:clink_like_id])
  	c_like = clink_like.c_likes.build(c_like_params)
  	if c_like.save
      contest = Contest.find(clink_like.contest_id)
      contest.c_link_like[:count] = clink_like.c_likes.count
      contest.save

      user_id = contest.u[:u_id]
      msg = { 
        user_id: user_id,
        resource: 'c_likes',
        action: 'create',
        element_id: c_like.id,
        u_id: c_like.u[:u_id],
        name: c_like.u[:name],
        avatar: c_like.u[:avatar],
        created_at: c_like.created_at
      }
      c_like[:cid] = params[:clink_like_id]
      $redis.publish 'contest-like', c_like.to_json
      if $redis.publish 'user-notification', msg.to_json
        UserNotification.create(msg)
      end
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
      contest = Contest.find(clink_like.contest_id)
      contest.c_link_like[:count] = clink_like.c_likes.count
      contest.save
  	  head 204
  	end
  end

  private
    def c_like_params
      params[:c_like][:u] = { :u_id => current_user.id.to_s, :name => current_user.name, :avatar => current_user.profile.avatar}
      params.require(:c_like).permit(:created_at, :u => [:u_id, :name, :avatar])
    end
end
