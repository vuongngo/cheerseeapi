class PlinkComment
  include Mongoid::Document
  belongs_to :participation
  embeds_many :p_comments
end
