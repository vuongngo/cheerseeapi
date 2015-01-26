class Chat
  include Mongoid::Document

  embeds_many :messages
end
