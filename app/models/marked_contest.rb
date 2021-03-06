class MarkedContest
  include Mongoid::Document

  embedded_in :user

  field :u,							type: Hash 
  field :contest_id,				type: String
  field :post,						type: String
  field :ended_at,					type: Integer

  validates_presence_of :u, :contest_id, :post, :ended_at
  validates_uniqueness_of :contest_id
  validates_numericality_of :ended_at, :only_integer => true
end
