require 'rails_helper'
include RandomNumber

describe Api::V1::ContestsController, :type => :controller do
  before do
  	@user = FactoryGirl.create :user
  end

  describe "GET#index" do
  	before(:each) do
  	  10.times { FactoryGirl.create :contest }
  	  api_authorization_header(@user.auth_token)
  	  get :index
  	end

  	it "returns 10 records from database" do
  	  contest_response = json_response
  	  expect(contest_response[:contests].size).to eq(10)
  	end

  	it { should respond_with 200 }
  end

  describe "POST#create" do 
  	context "when successfully create" do
  	  before(:each) do 
  	  	@contest_attributes = FactoryGirl.attributes_for :contest
  	  	api_authorization_header(@user.auth_token)
  	  	post :create, { user_id: @user.id, contest: @contest_attributes }, format: :json
  	  end

  	  it "renders the json representation for the contest just created" do 
  	    contest_response = json_response
  	    expect(contest_response[:post]).to eql @contest_attributes[:post]
  	  end

  	  it { should respond_with 201 }
  	end

  	context "when not created" do
  	  before(:each) do
  	  	@invalid_contest_attributes = FactoryGirl.attributes_for :contest
  	  	@invalid_contest_attributes[:post] = ""
  	  	api_authorization_header(@user.auth_token)
  	  	post :create, { user_id: @user.id, contest: @invalid_contest_attributes}, format: :json
  	  end

  	  it "renders the json errors" do
  	  	contest_response = json_response
  	  	expect(contest_response).to have_key(:errors)
  	  end

  	  it "renders the errors on why contest can not be created" do 
  	  	contest_response = json_response
  	  	expect(contest_response[:errors][:post]).to include "can't be blank"
  	  end

  	  it { should respond_with 422 }
  	end
  end


end
