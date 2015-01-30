FactoryGirl.define do
  factory :clink_comment do
    contest
    c_comments { [FactoryGirl.build(:c_comment), FactoryGirl.build(:c_comment)] }
  end

end
