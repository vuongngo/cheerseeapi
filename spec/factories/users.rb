FactoryGirl.define do
  factory :user do
	email { Faker::Internet.email}
	password "12345678"
	password_confirmation "12345678" 
	gender { ["male", "female"].sample }
	profile { FactoryGirl.build(:profile) }   
  end

end
