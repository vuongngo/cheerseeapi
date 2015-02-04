FactoryGirl.define do
  factory :profile do
	age { 20 }
	location { Faker::Address.city }
	interests { Faker::Lorem.sentence }   
	avatar { Random.new.rand }
  end
end
