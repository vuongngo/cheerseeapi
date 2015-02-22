class ToConnection
  include Mongoid::Document

  embedded_in :user

  field :u,							type: Hash
  field :created_at,				type: Integer
  field :participation_id,			type: String
  field :chat_id,					type: String

  validate :created_at_is_valid_datetime
  validates_uniqueness_of :u
  validates_presence_of :u, :created_at, :participation_id, :chat_id
  validates_numericality_of :created_at, :only_integer => true
end
