FactoryGirl.define do
  factory :plink_comment do
	participation
	p_comments { [FactoryGirl.build(:p_comment), FactoryGirl.build(:p_comment)] }    
  end

end
