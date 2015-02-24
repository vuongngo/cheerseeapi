class Api::V1::MarkedContestsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def create
  	if params[:cid].present?
  	  contest = Contest.find(params[:cid]) 
  	  mark_contest = current_user.marked_contests.build(:u => contest.u, contest_id: params[:cid], :post => contest.post, ended_at: contest.ended_at)
  	  if mark_contest.save
  	    render json: mark_contest, status: 201, location: [:api, contest]
      else
        render json: { errors: contest.errors }, status: 422
      end
    else
      render json: { errors: "Invalid request"}, status: 500
    end
  end

  def destroy
  	current_user.marked_contests.where(contest_id: params[:id]).destroy_all
  	head 204
  end
end
