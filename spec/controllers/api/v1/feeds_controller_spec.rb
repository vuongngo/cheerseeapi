require 'rails_helper'

describe Api::V1::FeedsController do
  before do
  	@user = FactoryGirl.create :user
  end

  describe "GET#index" do
  	before(:each) do
  	  # 10.times { FactoryGirl.create :contest }
  	  # FactoryGirl automatically create contest records
  	  # because of association between contest and participation
  	  # hence we don't have to create contest records.
  	  100.times { FactoryGirl.create :participation }
  	  api_authorization_header(@user.auth_token) 
  	  get :index
  	end

  	it "returns 25 records from database" do
  		feeds_reponse = json_response
  		expect(feeds_reponse[:feeds].size).to eq(25)
  	end

    it { expect(json_response).to have_key(:meta) }
    it { expect(json_response[:meta]).to have_key(:pagination) }
    it { expect(json_response[:meta][:pagination]).to have_key(:per_page) }
    it { expect(json_response[:meta][:pagination]).to have_key(:total_pages) }
    it { expect(json_response[:meta][:pagination]).to have_key(:total_objects) }    

  	it { should respond_with 200 }
  end

  describe "GET#show" do
  	before(:each) do
  	  10.times { FactoryGirl.create :participation }
  	  participation_plus = FactoryGirl.build :participation
  	  participation_plus.u = { u_id: @user.id.to_s, name: @user.name }
  	  participation_plus.save
  	  contest_plus = FactoryGirl.create :contest
  	  contest_plus.u = { u_id: @user.id.to_s, name: @user.name }
  	  contest_plus.save
  	  api_authorization_header(@user.auth_token)
  	  get :show, { id: @user.id }
  	end

  	it "returns 2 records from database" do
  	  feeds_response = json_response
  	  expect(feeds_response[:feeds].size).to eq(2)
      expect(feeds_response[:user]).to have_key(:profile)
	  end

    it { expect(json_response).to have_key(:meta) }
    it { expect(json_response[:meta]).to have_key(:pagination) }
    it { expect(json_response[:meta][:pagination]).to have_key(:per_page) }
    it { expect(json_response[:meta][:pagination]).to have_key(:total_pages) }
    it { expect(json_response[:meta][:pagination]).to have_key(:total_objects) }

  	it { should respond_with 200 }
  end

  describe "GET#association" do
  	before(:each) do
  	  @participation = FactoryGirl.create :participation
  	  api_authorization_header(@user.auth_token)
  	  get :association, { id: @participation.contest_id }
  	end

  	it "returns association" do 
  	  feeds_response = json_response
  	  expect(feeds_response[:contest][0][:_id]).to have_value @participation.contest_id.to_s
      expect(feeds_response[:participations][0][:_id]).to have_value @participation.id.to_s            
  	end

    it { expect(json_response).to have_key(:meta) }
    it { expect(json_response[:meta]).to have_key(:pagination) }
    it { expect(json_response[:meta][:pagination]).to have_key(:per_page) }
    it { expect(json_response[:meta][:pagination]).to have_key(:total_pages) }
    it { expect(json_response[:meta][:pagination]).to have_key(:total_objects) }

  	it { should respond_with 200 }
  end
end
