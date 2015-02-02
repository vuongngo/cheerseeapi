class Api::V1::FeedsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
  	contest = Contest.all
  	participation = Participation.all 
  	activity = contest + participation
    activity.sort! { |a, b| b.created_at <=> a.created_at  }
    respond_with activity
  end

  def show
    user = User.find(params[:id])
  	contest = Contest.where('u.u_id' => BSON::ObjectId.from_string(params[:id]))
  	participation = Participation.where('u.u_id' => BSON::ObjectId.from_string(params[:id]))
  	activity = contest + participation
    activity.sort! { |a, b| b.created_at <=> a.created_at  }
    response = {:user => user, :feeds => activity}
    respond_with response
  end

  def association
  	contest = Contest.where(id: params[:contest_id])
  	participation = Participation.where(contest_id: BSON::ObjectId.from_string(params[:contest_id]) )
	  activity = contest + participation
  	respond_with activity
  end
end
