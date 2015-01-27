class Participation
  include Mongoid::Document
  field :u, 				type: Hash 

  belongs_to :contest

  field :post,              type: String
  field :point,				type: String
  field :winner_place, 		type: Integer
  field :created_at, 		type: Time
  field :updated_at, 		type: Time

  embeds_many :p_comments

  embeds_many :p_likes 
  
  validates_presence_of :u, :post, :point, :created_at, :updated_at
  validates_uniqueness_of :u, :scope => [:point, :post]
  index({ ended_at: 1 }, { unique: true })
end
