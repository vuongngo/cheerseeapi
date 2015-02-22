include RandomNumber
FactoryGirl.define do
  factory :p_like do
  	u { {:u_id => Random.new.rand, :name => Faker::Name.name} }
	created_at { rand_time(2.days.ago).to_i }                    
  end
end
