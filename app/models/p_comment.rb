class PComment
  include Mongoid::Document
  
  field :u,						type: Hash 

  field :post, 					type: String
  field :created_at, 			type: Integer

  embedded_in :participation

  validates_presence_of :u, :post, :created_at
  validates_uniqueness_of :u, :scope => [:post, :created_at]
  validates_numericality_of :created_at, :only_integer => true
end
