include RandomNumber
FactoryGirl.define do
  factory :participation do
  	u { {:u_id => Random.new.rand, :name => Faker::Name.name, :avatar => "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_GzlqlJe3SdMB0FAh4krF6j1GPongQOkzXaex6gE6S6rqUGU"} }
  	post { Faker::Lorem.sentence }
  	point { Random.new.rand(0..100) }
  	winner_place { Random.new.rand(0..10) }
	  created_at { rand_time(2.days.ago).to_i }
	  updated_at { rand_time(2.days.ago).to_i }
    pic { ["http://anhdep.pro/wp-content/uploads/2013/06/hinh-nen-de-thuong-cho-may-tinh-71.jpg", "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQM9SCN2oqtFpnXv74YJjWeCycJz0Zq87Etyv1jKqrfRwnrHmH6"] }
    contest
    p_link_comment{ {:comment_id => Random.new.rand, :count => Random.new.rand(0..100)} }
    p_link_like{ {:like_id => Random.new.rand, :count => Random.new.rand(0..100)} }
  end
end
