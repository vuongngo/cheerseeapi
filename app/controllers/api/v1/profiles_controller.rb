class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :update]
  respond_to :json

  def show
  	user = User.find_by('profile._id' => BSON::ObjectId.from_string(params[:id]))
  	respond_with user.profile
  end

  def update
    profile = current_user.profile
    if params[:avatar] != profile.avatar
      user = { name: current_user.name, u_id: current_user.id.to_s, avatar: params[:avatar]}
      contests = Contest.where('u.u_id' => current_user.id.to_s)
      contests.each do |f|
        f.update_attributes(:u => user)
      end
      participations = Participation.where('u.u_id' => current_user.id.to_s)
      participations.each do |f|
        f.update_attributes(:u => user)
      end
    end

    if profile.update(profile_params)
      render json: profile, status: 200, location: [:api, profile]
    else
      render json: { errors: profile.errors }, status: 422
    end
  end

  private
  	def profile_params
  	  params.require(:profile).permit(:age, :interests, :location, :avatar)
  	end	
end
