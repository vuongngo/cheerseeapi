include RandomNumber
FactoryGirl.define do
  factory :contest do
  	u { {:u_id => Random.new.rand, :name => Faker::Name.name, :avatar => "http://www.syracusenewtimes.com/wp-content/uploads/2014/10/zoe-saldana-as-neytiri-in-avatar.jpg"} }
  	post { Faker::Lorem.sentence }
  	att { Faker::Internet.slug }
  	rule { Faker::Internet.slug }
  	ended_at { rand_time(Time.now + 2.days).to_i } 
  	created_at { rand_time(2.days.ago).to_i }
  	updated_at { rand_time(2.days.ago).to_i }
    pic { [ "http://media.npr.org/images/picture-show-flickr-promo.jpg", "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQsYI4K6pquyZ3WrXtYBVA-NUinxjhOAc5tfmFpkjviMZPwMq40", "http://static.guim.co.uk/sys-images/Guardian/Pix/pictures/2013/11/8/1383914700800/Ancient-cities-picture-qu-001.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfYF1Ja0xNPwTgX1EvxaHcZouHqfJO1JQy5BtM1s4Y8jBbhskm" ]}
    c_link_comment { {:comment_id => Random.new.rand, :count => Random.new.rand(0..100)} }
    c_link_like { {:like_id => Random.new.rand, :count => Random.new.rand(0..100)} }
  end
end
