include RandomNumber
FactoryGirl.define do
  factory :marked_contest do
	u { {:u_id => Random.new.rand, :name => Faker::Name.name} }
	contest_id { Random.new.rand }
	post { Faker::Lorem.sentence }
	ended_at { rand_time(2.days.ago) }    
  end

end
