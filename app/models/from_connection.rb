class FromConnection
  include Mongoid::Document
  embedded_in :user

  field :u,							type: Hash
  field :created_at,				type: Integer
  field :contest_id,				type: String
  field :chat_id,					type: String

  validates_presence_of :u, :created_at, :contest_id, :chat_id
  validates_uniqueness_of :u
  validates_numericality_of :created_at, :only_integer => true
end
