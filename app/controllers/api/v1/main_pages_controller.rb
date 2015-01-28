class Api::V1::MainPagesController < ApplicationController
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
  	contest = Contest.where('u.u_id' => BSON::ObjectId.from_string(params[:id]))
  	participation = Participation.where('u.u_id' => BSON::ObjectId.from_string(params[:id]))
  	activity = contest + participation
    activity.sort! { |a, b| b.created_at <=> a.created_at  }
    respond_with activity
  end

  def association
  	contest = Contest.where(id: params[:contest_id])
  	participation = Participation.where(contest_id: BSON::ObjectId.from_string(params[:contest_id]) )
	activity = contest + participation
  	respond_with activity
  end
end
