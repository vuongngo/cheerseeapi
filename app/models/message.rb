class Message
  include Mongoid::Document
  embedded_in :chat

  field :u,					type: Hash 
  field :mes,				type: String
  field :created_at,		type: DateTime
  
  validate :created_at_is_valid_datetime
  validates_presence_of :u, :mes, :created_at
  validates_uniqueness_of :u, :scope => [:mes, :created_at]
end
