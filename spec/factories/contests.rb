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
    pic { [ Random.new.rand, Random.new.rand ]}
    c_link_comment { {:comment_id => Random.new.rand, :count => Random.new.rand(0..100)} }
    c_link_like { {:like_id => Random.new.rand, :count => Random.new.rand(0..100)} }
  end
end
