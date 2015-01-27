class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_with_token!, only: [:show]
  respond_to :json

  def show
  	user = User.find_by('profile._id' => BSON::ObjectId.from_string(params[:id]))
  	respond_with user.profile
  end	
end
