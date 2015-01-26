class Participation
  include Mongoid::Document
  field :user, 				type: Hash 

  belongs_to :contest

  field :post,              type: String
  field :point,				type: String
  field :winner_place, 		type: Integer
  field :created_at, 		type: Time
  field :updated_at, 		type: Time

  embeds_many :p_comments

  embeds_may :p_likes 

  index({ ended_at: 1 }, { unique: true })
end
