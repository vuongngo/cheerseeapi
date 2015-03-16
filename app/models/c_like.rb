class CLike
  include Mongoid::Document

  field :u, 					type: Hash 
  field :created_at,			type: Integer
  field :avatar,				type: String

  embedded_in :clink_like

  validates_presence_of :u, :created_at
  validates_uniqueness_of :u
  validates_numericality_of :created_at, :only_integer => true
end
