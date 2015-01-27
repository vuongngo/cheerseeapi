class Contest
  include Mongoid::Document

  field :u, 				type: Hash 

  field :post,              type: String
  field :att,				type: String
  field :rule, 				type: String
  field :ended_at,			type: Time
  field :created_at, 		type: Time
  field :updated_at, 		type: Time
  field :winner, 			type: Array

  embeds_many :c_comments
  embeds_many :c_likes

  has_many :participations, :dependent => :destroy
  
  validates_presence_of :u, :post, :att, :rule, :ended_at, :created_at, :updated_at
  validates_uniqueness_of :u, :scope => [:att, :rule]
  index({ ended_at: 1 }, { unique: true })

end
