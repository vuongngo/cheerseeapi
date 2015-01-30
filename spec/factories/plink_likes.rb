FactoryGirl.define do
  factory :plink_like do
	participation
	p_likes { [FactoryGirl.build(:p_like), FactoryGirl.build(:p_like)] }    
  end

end
