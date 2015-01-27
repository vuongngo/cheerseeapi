class PLike
  include Mongoid::Document

  embedded_in :participation

  field :u, 					type: Hash 
  field :created_at,			type: Time
  
  validates_presence_of :u, :created_at
  validates_uniqueness_of :u
end
