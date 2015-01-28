class Api::V1::ParticipationsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
  	respond_with Participation.all
  end

  def create
  	contest = Contest.find(params[:contest_id])
  	participation = contest.participations.build(participation_params)
  	if participation.save
  	  render json: participation, status: 201, location: [:api, participation]
  	else 
  	  render json: { errors: participation.errors }, status: 422
  	end
  end

  def update
  	participation = Participation.find(params[:id])
  	if participation.update_attributes(participation_params) && participation.u[:u_id] == current_user.id
  	  render json: participation, status: 200, location: [:api, participation]
  	else
  	  render json: { errors: participation.errors }, status: 422
  	end
  end

  def destroy
  	participation = Participation.find(params[:id])
  	if participation.u[:u_id] == current_user.id
	  participation.destroy
	  head 204
	end
  end  	  

  private
    def participation_params
      params.require(:participation).permit(:post, :point, :created_at, :updated_at, :u => [:u_id, :name])
    end
end
