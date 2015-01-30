class Participation
  include Mongoid::Document
  include DateTimeValidation
  field :u, 				        type: Hash 

  belongs_to :contest

  field :post,              type: String
  field :point,				      type: String
  field :winner_place, 		  type: Integer
  field :pic,               type: Array
  field :created_at, 		    type: DateTime
  field :updated_at, 		    type: DateTime

  has_one :plink_comment
  field :plink_comment,     type: Hash
  has_one :plink_like
  field :plink_like,        type: Hash 

  validate :created_at_is_valid_datetime
  validate :updated_at_is_valid_datetime
  validates_presence_of :u, :post, :point, :created_at, :updated_at
  validates_uniqueness_of :u, :scope => [:point, :post]
end
