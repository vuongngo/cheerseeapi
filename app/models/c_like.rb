class CLike
  include Mongoid::Document

  embedded_in :contest

  field :u, 					type: Hash 
  field :created_at,			type: Time
  
  validates_presence_of :u, :created_at
  validates_uniqueness_of :u
end
