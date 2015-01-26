class FromConnection
  include Mongoid::Document
  embedded_in :user

  field :user,						type: Hash
  field :created_at,				type: Time
  field :contest_id,				type: String
  field :chat_id,					type: String
end
