FactoryGirl.define do
  factory :clink_like do
	contest
	c_likes { [FactoryGirl.build(:c_like), FactoryGirl.build(:c_like)] }    
  end

end
