class PlinkLike
  include Mongoid::Document
  belongs_to :participation
  embeds_many :p_likes
end
