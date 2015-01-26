class Message
  include Mongoid::Document
  embedded_in :chat

  field :user,				type: Hash 
  field :mes,				type: String
end
