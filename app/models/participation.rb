class Participation
  include Mongoid::Document
  field :u, 				        type: Hash 

  belongs_to :contest

  field :post,              type: String
  field :point,				      type: String
  field :winner_place, 		  type: Integer
  field :pic,               type: Array
  field :created_at, 		    type: Integer
  field :updated_at, 		    type: Integer

  has_one :plink_comment
  field :p_link_comment,     type: Hash
  has_one :plink_like
  field :p_link_like,        type: Hash 

  validates_presence_of :u, :post, :point, :created_at, :updated_at
  validates_uniqueness_of :u, :scope => [:point, :post]
  validates_numericality_of :created_at, :only_integer => true
  validates_numericality_of :updated_at, :only_integer => true

  after_create :create_associated_records

  private
    def create_associated_records
      plink_comment = self.build_plink_comment
      if plink_comment.save
        self.update_attributes(:p_link_comment => {:comment_id => plink_comment.id, :count => 0} )
      end
      plink_like = self.build_plink_like
      if plink_like.save
        self.update_attributes(:p_link_like => {:like_id => plink_like.id, :count => 0} )
      end
    end
end
