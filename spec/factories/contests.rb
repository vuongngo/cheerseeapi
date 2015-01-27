include RandomNumber
FactoryGirl.define do
  factory :contest do
  	u { {:u_id => Random.new.rand, :name => Faker::Name.name} }
  	post { Faker::Lorem.sentence }
  	att { Faker::Internet.slug }
  	rule { Faker::Internet.slug }
  	ended_at { rand_time(2.days.ago) } 
	created_at { rand_time(2.days.ago) }
	updated_at { rand_time(2.days.ago) }
	winner { rand_array }
  end

end
