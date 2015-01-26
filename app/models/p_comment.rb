class PComment
  include Mongoid::Document

  field :user,					type: Hash 

  field :post, 					type: String
  field :created_at, 			type: Time

  embedded_in :participation
end
