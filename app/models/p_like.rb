class PLike
  include Mongoid::Document
  
  embedded_in :participation

  field :u, 					type: Hash 
  field :created_at,			type: Integer
  
  validates_presence_of :u, :created_at
  validates_uniqueness_of :u
  validates_numericality_of :created_at, :only_integer => true
end
