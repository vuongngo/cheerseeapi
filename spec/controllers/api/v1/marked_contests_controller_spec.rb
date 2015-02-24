require 'rails_helper'

describe Api::V1::MarkedContestsController, :type => :controller do
  before do
  	@user = FactoryGirl.create :user
  	@contest = FactoryGirl.create :contest
  end

  describe 'POST#create' do
  	context "when successfully created" do
  	  before(:each) do
  	    @marked_contest_attributes = {:u => @contest.u, :contest_id => @contest.id, :post => @contest.post, :ended_at => @contest.ended_at}
  	    api_authorization_header(@user.auth_token)
  	    post :create, {:cid => @marked_contest_attributes[:contest_id]}, :format => :json
  	  end

  	  it "renders the json representative for the contest just created" do
  	  	marked_contest_response = json_response
  	  	expect(marked_contest_response[:post]).to eql @marked_contest_attributes[:post]
  	  end

  	  it { should respond_with 201 } 
  	end

  	context "when failed to create" do
  	  before(:each) do
  	  	invalid_marked_context_attributes = {:contest_id => @contest.id, :post => @contest.post, :ended_at => @contest.ended_at}
  	  	api_authorization_header(@user.auth_token)
  	  	post :create, :format => :json_response
  	  end

  	  it "render the json errors" do
  	  	marked_contest_response = json_response
  	  	expect(marked_contest_response).to have_key(:errors)
  	  end

  	  it "render the json error explain why failed to created" do
  	  	marked_contest_response = json_response
  	  	expect(marked_contest_response[:errors]).to include "Invalid request"
  	  end
  	end
  end

  describe 'DELETE#destroy' do
  	before(:each) do
  	  mark = @user.marked_contests.new(:u => @contest.u, :contest_id => @contest.id, :post => @contest.post, :ended_at => @contest.ended_at)
  	  mark.save
  	  api_authorization_header(@user.auth_token)
  	  delete :destroy, {:id => mark.contest_id}, :format => :json_response
  	end

  	it { should respond_with 204 }
  end
end
