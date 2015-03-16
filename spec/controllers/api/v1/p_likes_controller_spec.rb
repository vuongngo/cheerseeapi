require 'rails_helper'

describe Api::V1::PLikesController do
  before do 
  	@user = FactoryGirl.create :user
  	@plink_like = FactoryGirl.create :plink_like
  end

  describe "POST#create" do
  	context "when successfully created" do
  	  before(:each) do
        @participation = Participation.find(@plink_like.participation_id)
  	  	@p_like_attributes = FactoryGirl.attributes_for :p_like
  	    api_authorization_header(@user.auth_token)
  	    post :create, { user_id: @user.id, plink_like_id: @plink_like.id, p_like: @p_like_attributes }
  	  end

  	  it "renders the json representation of like created" do
  	  	p_like_response = json_response
  	  	expect(p_like_response[:created_at]).to eql @p_like_attributes[:created_at]
  	  end

      it "updates the participation p_link_like" do
        participation1 = Participation.find(@plink_like.participation_id)
        plink_like1 = PlinkLike.find(@plink_like.id)
        expect(participation1.p_link_like[:count]).to eql ( plink_like1.p_likes.count )
      end

      it "create user notification" do
        notification = UserNotification.find_by(created_at: @p_like_attributes[:created_at])
        expect(notification[:viewed]).to eql false
      end
       
  	  it { should respond_with 201 }
  	end

  	context "when fail to create" do
  	  before(:each) do
  	  	@invalid_p_like_attributes = FactoryGirl.attributes_for :p_like
  	  	@invalid_p_like_attributes[:u] = { u_id: @user.id, name: @user.name }
  	  	@invalid_p_like_attributes[:created_at] = "Yo"
  	  	api_authorization_header(@user.auth_token)
  	  	post :create, { user_id: @user.id, plink_like_id: @plink_like.id, p_like: @invalid_p_like_attributes }
  	  end

  	  it "renders the json errors" do
  	  	p_like_response = json_response
  	  	expect(p_like_response).to have_key(:errors)
  	  end

  	  it "renders the json explain why fail to create" do
  	  	p_like_response = json_response
  	  	expect(p_like_response[:errors][:created_at]).to include "is not a number"
  	  end

  	  it { should respond_with 422 }
  	end
  end

  describe "DELETE#destroy" do
  	before(:each) do
      @participation = Participation.find(@plink_like.participation_id)
  	  @p_like = @plink_like[:p_likes].first
  	  fetch = @p_like["u"][:u_id]
  	  @user1 = FactoryGirl.build :user
  	  @user1[:id] = fetch
  	  @user1.save
  	  api_authorization_header(@user1.auth_token)
  	  delete :destroy, { user_id: @user1.id, plink_like_id: @plink_like.id, id: @p_like["_id"] }
  	end

    it "updates the participation p_link_like" do
      participation1 = Participation.find(@plink_like.participation_id)
      plink_like1 = PlinkLike.find(@plink_like.id)
      expect(participation1.p_link_like[:count]).to eql ( plink_like1.p_likes.count )
    end
  	
    it { should respond_with 204 }
  end
end
