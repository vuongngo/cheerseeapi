class Contest
  include Mongoid::Document

  field :user, 				type: Hash 

  field :post,              type: String
  field :attr,				type: String
  field :rule, 				type: String
  field :ended_at,			type: Time
  field :created_at, 		type: Time
  field :updated_at, 		type: Time
  field :winner, 			type: Array

  embeds_many :c_comments
  embeds_many :c_likes

  has_many :participations

  index({ ended_at: 1 }, { unique: true })

end
