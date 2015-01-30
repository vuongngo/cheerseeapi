class Contest
  include Mongoid::Document
  include DateTimeValidation
  field :u, 				         type: Hash 

  field :post,               type: String
  field :att,				         type: String
  field :rule, 				       type: String
  field :ended_at,			     type: DateTime
  field :created_at, 		     type: DateTime
  field :updated_at, 		     type: DateTime
  field :winner, 			       type: Array
  field :pic,                type: Array

  has_one :clink_comment
  field :c_link_comment,      type: Hash
  has_one :clink_like
  field :c_link_like,         type: Hash

  has_many :participations, :dependent => :destroy
  
  validate :created_at_is_valid_datetime
  validate :updated_at_is_valid_datetime
  validate :ended_at_is_valid_datetime
  validates_presence_of :u, :post, :att, :rule, :ended_at, :created_at, :updated_at
  validates_uniqueness_of :u, :scope => [:att, :rule]
  index({ ended_at: 1 }, { unique: true })

  after_create :create_associated_records
  
  private
    def create_associated_records
      clink_comment = self.build_clink_comment
        if clink_comment.save
          self.update_attributes(:c_link_comment => {:comment_id => clink_comment.id, :count => 0} )
        end
      clink_like = self.build_clink_like
        if clink_like.save
          self.update_attributes(:c_link_like => {:like_id => clink_like.id, :count => 0} )
        end
    end
end
