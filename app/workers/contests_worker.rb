class ContestsWorker
  include Sidekiq::Worker
  
  def perform(id)
    contest = Contest.find(id)
    participation = Participation.where(contest_id: id).order_by(:point.desc, :create_at.asc).first
    if participation.present?  
      win = [participation]
      winner = User.find(participation.u.u_id)
      poster = User.find(contest.u.u_id)
      if contest.update_attributes(winner: win) && participation.update_attributes(winner_place: 1)
        winner.update_attributes(from_connections: participation)
        poster.update_attributes(to_connection: contest)
      	# Push to redis notification
      else
      	# Send email to user
      end
    else
      contest.update_attributes(winner: ["null"])
      # Push to redis notification
    end
  end
end