class Achievement
  include Mongoid::Document

  embedded_in :user

  field :participation_id, 				type: String
  field :contest_id,					type: String
  field :winner_place,					type: Integer

  validates_presence_of :participation_id, :contest_id, :winner_place
  validates_uniqueness_of :participation_id, :scope => [:contest_id]
end
