FactoryGirl.define do
  factory :profile do
	name { Faker::Name.name }
	gender "Male"
	age { Random.new.rand(18..90) }
	location { Faker::Address.city }
	interests { Faker::Lorem.sentence }   
  end

end
