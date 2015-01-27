class CComment
  include Mongoid::Document

  field :u,					type: Hash 

  field :post,				type: String
  field :created_at,		type: Time

  embedded_in :contest

  validates_presence_of :u, :post, :created_at
  validates_uniqueness_of :u, :scope => [:post, :created_at]
end
