class ClinkComment
  include Mongoid::Document
  belongs_to :contest
  embeds_many :c_comments
end
