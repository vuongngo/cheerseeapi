class PLike
  include Mongoid::Document

  embedded_in :participation

  field :user, 					type: Hash 
  field :created_at,			type: Time
end
