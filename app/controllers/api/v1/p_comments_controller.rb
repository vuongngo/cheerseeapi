class Api::V1::PCommentsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    plink_commment = PlinkComment.find(params[:plink_comment_id])
    p_comments = plink_commment.p_comments.sort!{ |a, b| b.created_at <=> a.created_at }
    p_comments = Kaminari.paginate_array(plink_commment.p_comments).page(params[:page]).per(5)
    render json: { :comments => p_comments, meta: { pagination:
                                                  { per_page: 5,
                                                    total_pages: p_comments.total_pages,
                                                    total_objects: p_comments.total_count } } }
  end

  def create
  	plink_comment = PlinkComment.find(params[:plink_comment_id])
  	p_comment = plink_comment.p_comments.build(p_comment_params)
  	if p_comment.save
      participation = Participation.find(plink_comment.participation_id)
      participation.p_link_comment[:count] = plink_comment.p_comments.count
      participation.save

      user_id = participation.u[:u_id]
      msg = {
        user_id: user_id,
        resource: 'p_comments',
        action: 'create',
        element_id: p_comment.id,
        u_id: p_comment.u[:u_id],
        name: p_comment.u[:name],
        avatar: p_comment.u[:avatar],
        post: p_comment.post,
        created_at: p_comment.created_at
      }
      p_comment[:pid] = params[:plink_comment_id]
      $redis.publish 'participation-comment', p_comment.to_json
      if $redis.publish 'user-notification', msg.to_json
        UserNotification.create(msg)
      end
  	  render json: p_comment, status: 201
  	else
  	  render json: { errors: p_comment.errors }, status: 422
  	end
  end

  def update
  	plink_comment = PlinkComment.find(params[:plink_comment_id])
  	p_comment = plink_comment.p_comments.find(params[:id])
  	if p_comment.update_attributes(update_params) && p_comment[:u][:u_id] == current_user.id
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
      p_comment.destroy
      participation.p_link_comment[:count] = plink_comment.p_comments.count
      participation.save	  
	    head 204
	  end
  end

  private
    def p_comment_params
      params[:p_comment][:u] = { :u_id => current_user.id.to_s, :name => current_user.name, :avatar => current_user.profile.avatar }
      params.require(:p_comment).permit(:post, :created_at, :u => [:u_id, :name, :avatar] )
    end

    def update_params
      params.require(:p_comment).permit(:post, :created_at)
    end
end
