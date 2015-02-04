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
  	  expect(profile_response[:age]).to eql @profile.age
  	end

  	it { should respond_with 200 }
  end

  describe "PUT/PATCH#update" do
  	before(:each) do
  	  @user = FactoryGirl.create :user
  	  @profile = @user.profile
  	  api_authorization_header(@user.auth_token)
  	end

  	context "when is successfully updated" do
  	  before(:each) do
  	  	patch :update, { id: @profile.id, profile: {age: 99} }
  	  end

  	  it "render the json representation for the updated user" do 
  	  	profile_response = json_response
  	  	expect(profile_response[:age]).to eql 99
  	  end

  	  it { should respond_with 200 }
  	end

  	context "when is not updated" do
  	  before(:each) do 
  	  	patch :update, { id: @profile.id, profile: {age: "true"} }
  	  end

  	  it "render the error json response" do
  	  	profile_response = json_response
  	  	expect(profile_response).to have_key(:errors)
  	  end

  	  it "render the json errors on why the user could not be created" do
  	  	profile_response = json_response
  	  	expect(profile_response[:errors][:age]).to include "is not a number"
  	  end

  	  it { should respond_with 422 }
  	end
  end
end
