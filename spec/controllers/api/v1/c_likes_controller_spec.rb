require 'rails_helper'

describe Api::V1::CLikesController do
  before do 
  	@user = FactoryGirl.create :user
  	@clink_like = FactoryGirl.create :clink_like
  end

  describe "POST#create" do
  	context "when successfully created" do
  	  before(:each) do
        @contest = Contest.find(@clink_like.contest_id)
  	  	@c_like_attributes = FactoryGirl.attributes_for :c_like
  	  	@c_like_attributes[:u] = { u_id: @user.id, name: @user.name }
  	    api_authorization_header(@user.auth_token)
  	    post :create, { user_id: @user.id, clink_like_id: @clink_like.id, c_like: @c_like_attributes }
  	  end

  	  it "renders the json representation of like created" do
  	  	c_like_response = json_response
  	  	expect(c_like_response[:created_at]).to eql @c_like_attributes[:created_at]
  	  end

      it "updates the contest c_link_like" do
        @contest1 = Contest.find(@clink_like.contest_id)
        expect(@contest1.c_link_like[:count]).to eql ( @contest.c_link_like[:count] + 1)
      end 

  	  it { should respond_with 201 }
  	end

  	context "when fail to create" do
  	  before(:each) do
  	  	@invalid_c_like_attributes = FactoryGirl.attributes_for :c_like
  	  	@invalid_c_like_attributes[:u] = { u_id: @user.id, name: @user.name }
  	  	@invalid_c_like_attributes[:created_at] = "Yo"
  	  	api_authorization_header(@user.auth_token)
  	  	post :create, { user_id: @user.id, clink_like_id: @clink_like.id, c_like: @invalid_c_like_attributes }
  	  end

  	  it "renders the json errors" do
  	  	c_like_response = json_response
  	  	expect(c_like_response).to have_key(:errors)
  	  end

  	  it "renders the json explain why fail to create" do
  	  	c_like_response = json_response
  	  	expect(c_like_response[:errors][:created_at]).to include "is not a number"
  	  end

  	  it { should respond_with 422 }
  	end
  end

  describe "DELETE#destroy" do
  	before(:each) do
      @contest = Contest.find(@clink_like.contest_id)
  	  @c_like = @clink_like[:c_likes].first
  	  fetch = @c_like["u"][:u_id]
  	  @user1 = FactoryGirl.build :user
  	  @user1[:id] = fetch
  	  @user1.save
  	  api_authorization_header(@user1.auth_token)
  	  delete :destroy, { user_id: @user1.id, clink_like_id: @clink_like.id, id: @c_like["_id"] }
  	end

    it "updates the contest c_link_like" do
      @contest1 = Contest.find(@clink_like.contest_id)
      expect(@contest1.c_link_like[:count]).to eql ( @contest.c_link_like[:count] - 1)
    end

  	it { should respond_with 204 }
  end
end
