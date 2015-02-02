class Api::V1::FeedsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
  	contest = Contest.all
  	participation = Participation.all 
  	activity = contest + participation
    activity.sort! { |a, b| b.created_at <=> a.created_at  }
    activity = Kaminari.paginate_array(activity).page(params[:page]).per(params[:per_page])
    render json: { :feeds => activity, meta: { pagination:
                                                  { per_page: params[:per_page],
                                                    total_pages: activity.total_pages,
                                                    total_objects: activity.total_count } } }
  end

  def show
    user = User.find(params[:id])
  	contest = Contest.where('u.u_id' => BSON::ObjectId.from_string(params[:id]))
  	participation = Participation.where('u.u_id' => BSON::ObjectId.from_string(params[:id]))
  	activity = contest + participation
    activity.sort! { |a, b| b.created_at <=> a.created_at  }
    activity = Kaminari.paginate_array(activity).page(params[:page]).per(params[:per_page])
    render json: { :user => user, :feeds => activity, meta: { pagination:
                                                  { per_page: params[:per_page],
                                                    total_pages: activity.total_pages,
                                                    total_objects: activity.total_count } } }
  end

  def association
  	contest = Contest.where(id: params[:contest_id])
  	participations = Participation.where(contest_id: BSON::ObjectId.from_string(params[:contest_id])).page(params[:page]).per(params[:per_page])
    if participations.present?
    render json: { contest: contest, participations: participations, meta: { pagination:
                                                  { per_page: params[:per_page],
                                                    total_pages: participations.total_pages,
                                                    total_objects: participations.total_count } } }
    end
  end
end
