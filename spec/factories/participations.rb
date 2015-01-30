include RandomNumber
FactoryGirl.define do
  factory :participation do
  	u { {:u_id => Random.new.rand, :name => Faker::Name.name} }
  	post { Faker::Lorem.sentence }
  	point { Random.new.rand(0..100) }
  	winner_place { Random.new.rand(0..10) }
	  created_at { rand_time(2.days.ago) }
	  updated_at { rand_time(2.days.ago) }
    pic { [ Random.new.rand, Random.new.rand ]}
    contest
  end
end
