require 'rails_helper'

RSpec.describe User, :type => :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }

  it { should be_valid }

  describe "when email is not present" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('emample@domain.com').for(:email) }
  end

  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:auth_token) }

  describe "#generate_authentication_token" do
    it "generates a unique token" do 
      random_token = SecureRandom.urlsafe_base64(nil, false)
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql random_token
    end

    it "generates another token when one is already taken" do 
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end
end
