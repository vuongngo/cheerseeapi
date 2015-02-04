class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :update]
  respond_to :json

  def show
  	user = User.find_by('profile._id' => BSON::ObjectId.from_string(params[:id]))
  	respond_with user.profile
  end

  def update
    profile = current_user.profile
    if profile.update(profile_params)
      render json: profile, status: 200, location: [:api, profile]
    else
      render json: { errors: profile.errors }, status: 422
    end
  end

  private
  	def profile_params
  	  params.require(:profile).permit(:gender, :age, :location)
  	end	
end
