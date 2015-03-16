include RandomNumber
FactoryGirl.define do
  factory :user_notification do
    resource "c_comments"
    action "create"
    element_id { Random.new.rand }
    u_id { Random.new.rand }
    name { Faker::Name.name }
    created_at { rand_time(2.days.ago).to_i }
  end
end
