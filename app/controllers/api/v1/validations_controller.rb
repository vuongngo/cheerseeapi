class Api::V1::ValidationsController < ApplicationController
  respond_to :html, :json

  def email_check
  	if User.where(email: params[:user_email]).exists?
  	  render json: {isValid: false}, status: 200
  	else
  	  render json: {isValid: true}, status: 200
  	end
  end
end
