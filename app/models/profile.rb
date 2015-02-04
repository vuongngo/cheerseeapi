class Profile
  include Mongoid::Document

  embedded_in :user

  field :age,				type: Integer, default: 20
  field :location,			type: String
  field :interests,			type: String
  field :avatar,			type: String
  validates_numericality_of :age, :only_integer => true
end
