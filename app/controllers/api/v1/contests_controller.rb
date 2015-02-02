class Api::V1::ContestsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json
  
  def index
    contests = Contest.all.page(params[:page]).per(params[:per_page])
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
  	if contest.update_attributes(contest_params) && contest.u[:u_id] == current_user.id
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
      params.require(:contest).permit(:post, :att, :rule, :ended_at, :created_at, :updated_at, :u => [:u_id, :name])
    end
end
