class Api::V1::ContestsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json
  
  def index
    contests = Contest.order_by(:created_at.desc).limit(100).page(params[:page]).per(params[:per_page])
    render json: contests, meta: { pagination:
                                   { per_page: params[:per_page],
                                     total_pages: contests.total_pages,
                                     total_objects: contests.total_count } }
  end
  
  def create
  	contest = Contest.new(contest_params)
    if contest.save
      render json: contest, status: 201, location: [:api, contest]
    else
      render json: { errors: contest.errors }, status: 422
    end
  end

  def update
  	contest = Contest.find_by(id: params[:id])
  	if contest.update_attributes(update_params) && contest.u[:u_id] == current_user.id
  	  render json: contest, status: 200, location: [:api, contest]
  	else
  	  render json: { errors: contest.errors }, status: 422
  	end
  end

  def destroy
  	contest = Contest.find_by(id: params[:id])
  	if contest.u[:u_id] == current_user.id
  	  contest.destroy
  	  head 204
  	end
  end

  private
    def contest_params
      params[:contest][:u] = { :u_id => current_user.id.to_s, :name => current_user.name, :avatar => current_user.profile.avatar }
      params.require(:contest).permit(:post, :att, :rule, :ended_at, :created_at, :updated_at, :pic => [], :u => [:u_id, :name, :avatar])
    end
    
    def update_params
      params.require(:contest).permit(:post, :att, :rule, :ended_at, :created_at, :updated_at, :pic)
    end
end
