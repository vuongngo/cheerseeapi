class Message
  include Mongoid::Document
  embedded_in :chat

  field :u,					type: Hash 
  field :mes,				type: String
  field :created_at,		type: Integer
  
  validates_presence_of :u, :mes, :created_at
  validates_uniqueness_of :u, :scope => [:mes, :created_at]
  validates_numericality_of :created_at, :only_integer => true
end
