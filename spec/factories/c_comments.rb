include RandomNumber
FactoryGirl.define do
  factory :c_comment do
  	u { {:u_id => Random.new.rand, :name => Faker::Name.name} }
	post { Faker::Lorem.sentence }
	created_at { rand_time(2.days.ago) }            
  end
end
