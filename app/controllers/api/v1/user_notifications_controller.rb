class Api::V1::UserNotificationsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
  	user_notifications = UserNotification.where(user_id: current_user.id.to_s, viewed: false)
  	render json: user_notifications
  end

  def clear_notifications
  	user_notifications = UserNotification.where(user_id: current_user.id.to_s, viewed: false)
  	user_notifications.update_all(viewed: true)
  	render json: user_notifications
  end
end
