FactoryGirl.define do
  factory :achievement do
	participation_id { Random.new.rand }
	contest_id { Random.new.rand }
	winner_place { Random.new.rand(1..10) }    
  end

end
