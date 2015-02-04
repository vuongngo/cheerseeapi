require 'rails_helper'

describe Api::V1::ParticipationsController do
  before do
  	@user = FactoryGirl.create :user
 	@contest = FactoryGirl.create :contest
  end

  describe "GET#index" do
    before(:each) do
      10.times { FactoryGirl.create :participation }
      api_authorization_header(@user.auth_token)
      get :index
    end

    it "returns 10 records from database" do
      contest_response = json_response
      expect(contest_response[:participations].size).to eq(10)
    end

    it { expect(json_response).to have_key(:meta) }
    it { expect(json_response[:meta]).to have_key(:pagination) }
    it { expect(json_response[:meta][:pagination]).to have_key(:per_page) }
    it { expect(json_response[:meta][:pagination]).to have_key(:total_pages) }
    it { expect(json_response[:meta][:pagination]).to have_key(:total_objects) }
    
    it { should respond_with 200 }
  end  

  describe "POST#create" do
  	context "when successfully created" do
  	  before(:each) do 
  	  	@participation_attributes = FactoryGirl.attributes_for :participation
  	  	@participation_attributes[:u] = { :u_id => @user.id, :name => @user.name }
  	  	api_authorization_header(@user.auth_token)
  	  	post :create, { user_id: @user.id, contest_id: @contest.id, participation: @participation_attributes }
  	  end

  	  it "returns the json representation for the participation just created" do 
  	  	participation_response = json_response
  	  	expect(participation_response[:post]).to eql @participation_attributes[:post]
  	  end

  	  it { should respond_with 201 }
  	end

  	context "when fail to created" do
  	  before(:each) do
  	  	@invalid_participation_attributes = FactoryGirl.attributes_for :participation
  	  	@invalid_participation_attributes[:post] = ""
  	  	api_authorization_header(@user.auth_token)
  	  	post :create, { user_id: @user.id, contest_id: @contest.id, participation: @participation_attributes }
  	  end
  	  
  	  it "returns the json errors" do
  	    participation_response = json_response
  	    expect(participation_response).to have_key(:errors)
  	  end

  	  it "returns the json on why participation fail to create" do
  	    participation_response = json_response
  	    expect(participation_response[:errors][:post]).to include "can't be blank"
  	  end

  	  it { should respond_with 422 }
  	end
  end

  describe "PUT/PATCH#update" do 
  	before(:each) do
  	  @participation = FactoryGirl.build :participation
  	  @participation.u = { u_id: @user.id, name: @user.name }
  	  @participation.save
  	  api_authorization_header(@user.auth_token)
  	end 

  	context "when successfully updated" do
  	  before(:each) do
  	    patch :update, { user_id: @user.id, id: @participation.id, participation: { post: "Hohoho" } }
  	  end

  	  it "returns the json updated representation" do
  	  	participation_response = json_response
  	  	expect(participation_response[:post]).to eql "Hohoho"
  	  end

  	  it { should respond_with 200 }
  	end

  	context "when fail to update" do 
  	  before(:each) do
  	    patch :update, { user_id: @user.id, id: @participation.id, participation: { post: "" } }
  	  end

  	  it "returns json errors" do
  	  	participation_response = json_response
  	  	expect(participation_response).to have_key(:errors)
  	  end

  	  it "returns json explain on why fail to update" do
  	  	participation_response = json_response
  	  	expect(participation_response[:errors][:post]).to include "can't be blank"
  	  end

  	  it { should respond_with 422 }
  	end
  end

  describe "DELETE#destroy" do
  	before(:each) do
  	  @participation = FactoryGirl.build :participation
  	  @participation.u = { u_id: @user.id, name: @user.name }
  	  @participation.save
  	  api_authorization_header(@user.auth_token)
  	  delete :destroy, { user_id: @user.id, id: @participation.id }
  	end

  	it { should respond_with 204 }
  end
end
