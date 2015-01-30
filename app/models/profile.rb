class Profile
  include Mongoid::Document

  embedded_in :user

  field :name,				type: String, default: "Anonymous"
  field :age,				type: Integer
  field :location,			type: String
  field :interests,			type: String
  field :avatar,			type: String
  validates_presence_of :name
end
