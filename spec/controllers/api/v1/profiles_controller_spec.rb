require 'rails_helper'

describe Api::V1::ProfilesController do

  describe "GET#show" do
  	before(:each) do
  	  @user = FactoryGirl.create :user
  	  @profile = @user.profile
      api_authorization_header(@user.auth_token)
  	  get :show, id: @profile.id, format: :json
  	end

  	it "returns information about profile on a hash" do
      profile_response = json_response
  	  expect(profile_response[:name]).to eql @profile.name
  	end

  	it { should respond_with 200 }
  end
end
