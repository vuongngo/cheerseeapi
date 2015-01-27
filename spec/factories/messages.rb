include RandomNumber
FactoryGirl.define do
  factory :message do
   	u { {:u_id => Random.new.rand, :name => Faker::Name.name} }
   	mes { Faker::Lorem.sentence }
	created_at { rand_time(2.days.ago) }                
  end
end
