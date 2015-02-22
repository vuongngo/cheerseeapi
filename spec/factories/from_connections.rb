include RandomNumber
FactoryGirl.define do
  factory :from_connection do
  	u { {:u_id => Random.new.rand, :name => Faker::Name.name} }
	contest_id { Random.new.rand }
	chat_id { Random.new.rand }
	created_at { rand_time(2.days.ago).to_i }            
  end
end
