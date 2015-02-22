module Authenticable

  #Devise methods overwrite
  def current_user
    token = request.headers['Authorization'].split(' ').last
    if AuthToken.valid?(token) 
  	  @current_user ||= User.find_by(:auth_token => token)
    end
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" }, status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end
end