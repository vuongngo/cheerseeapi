class PLike
  include Mongoid::Document
  include DateTimeValidation
  
  embedded_in :participation

  field :u, 					type: Hash 
  field :created_at,			type: DateTime
  
  validate :created_at_is_valid_datetime
  validates_presence_of :u, :created_at
  validates_uniqueness_of :u
end
