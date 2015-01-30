class ClinkLike
  include Mongoid::Document
  belongs_to :contest
  embeds_many :c_likes
end
