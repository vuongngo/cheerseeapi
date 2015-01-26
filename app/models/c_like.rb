class CLike
  include Mongoid::Document

  embedded_in :contest

  field :user, 					type: Hash 
  field :created_at,			type: Time
end
