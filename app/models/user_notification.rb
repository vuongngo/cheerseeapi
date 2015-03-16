class UserNotification
  include Mongoid::Document
  field :user_id, 					type: String
  field :resource,					type: String
  field :action,					  type: String
  field :element_id,        type: String
  field :u_id,						  type: String
  field :name, 						  type: String
  field :avatar,					  type: String
  field :post, 						  type: String
  field :created_at,				type: Integer
  field :viewed, 					  type: Boolean, default: false

  validates_presence_of :user_id, :resource, :action, :u_id, :name, :created_at, :element_id
  validates_uniqueness_of :user_id, :scope => [:resource, :action, :u_id, :created_at, :element_id]
  validates_numericality_of :created_at, :only_integer => true

end
