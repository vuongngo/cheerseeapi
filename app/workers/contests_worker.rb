class ContestsWorker
  include Sidekiq::Worker
  
  def perform(id)
    contest = Contest.find(id)
    participation = Participations.where(contest_id: id).order_by(:point.desc, :create_at.asc).first
    winner_attributes = [participation]
    if contest.update_attributes(winner: winner_attributes)
    	# Push to redis notification
    else
    	# Send email to user
    end
  end
end