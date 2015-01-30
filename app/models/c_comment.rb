class CComment
  include Mongoid::Document
  include DateTimeValidation

  field :u,					type: Hash 

  field :post,				type: String
  field :created_at,		type: DateTime

  embedded_in :clink_comment

  validate :created_at_is_valid_datetime
  validates_presence_of :u, :post, :created_at
  validates_uniqueness_of :u, :scope => [:post, :created_at]
end
