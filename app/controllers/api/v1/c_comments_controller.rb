class Api::V1::CCommentsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    clink_commment = ClinkComment.find(params[:clink_comment_id])
    c_comments = Kaminari.paginate_array(clink_commment.c_comments).page(params[:page]).per(params[:per_page])
    render json: { :comments => c_comments, meta: { pagination:
                                                  { per_page: params[:per_page],
                                                    total_pages: c_comments.total_pages,
                                                    total_objects: c_comments.total_count } } }
  end

  def create
  	clink_comment = ClinkComment.find(params[:clink_comment_id])
  	c_comment = clink_comment.c_comments.build(c_comment_params)
  	if c_comment.save
      contest = Contest.find(clink_comment.contest_id)
      contest.c_link_comment[:count] =+ 1
      contest.save
  	  render json: c_comment, status: 201
  	else
  	  render json: { errors: c_comment.errors }, status: 422
  	end
  end

  def update
  	clink_comment = ClinkComment.find(params[:clink_comment_id])
  	c_comment = clink_comment.c_comments.find(params[:id])
  	if c_comment.update_attributes(update_params) && c_comment.u[:u_id] == current_user.id
  	  render json: c_comment, status: 200
  	else
      render json: { errors: c_comment.errors }, status: 422
    end
  end

  def destroy
  	clink_comment = ClinkComment.find(params[:clink_comment_id])
  	c_comment = clink_comment.c_comments.find(params[:id])
  	if c_comment.u[:u_id] == current_user.id
      contest = Contest.find(clink_comment.contest_id)
      contest.c_link_comment[:count] =- 1
      contest.save
  	  c_comment.delete
  	  head 204
  	end
  end

  private
    def c_comment_params
      params[:c_comment][:u] = { :u_id => current_user.id.to_s, :name => current_user.name, :avatar => current_user.profile.avatar }
      params.require(:c_comment).permit(:post, :created_at, :u => [:u_id, :name, :avatar])
    end

    def update_params
      params.require(:c_comment).permit(:post, :created_at)
    end
end
