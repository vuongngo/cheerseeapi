class ToConnection
  include Mongoid::Document

  embedded_in :user

  field :u,							type: Hash
  field :created_at,				type: Time
  field :participation_id,			type: String
  field :chat_id,					type: String

  validates_uniqueness_of :u
  validates_presence_of :u, :created_at, :participation_id, :chat_id
end
