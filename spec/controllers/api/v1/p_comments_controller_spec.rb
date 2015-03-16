require 'rails_helper'

describe Api::V1::PCommentsController do
  before do
  	@user = FactoryGirl.create :user
  	@plink_comment = FactoryGirl.create :plink_comment
  end

  describe "GET#index" do
    before(:each) do
      api_authorization_header(@user.auth_token)
      get :index, { plink_comment_id: @plink_comment.id}
    end

    it 'returns 20 records from database' do
      comments_response = json_response
      expect(comments_response[:comments].size).to eq(2)
    end

    it { expect(json_response).to have_key(:meta) }
    it { expect(json_response[:meta]).to have_key(:pagination) }
    it { expect(json_response[:meta][:pagination]).to have_key(:per_page) }
    it { expect(json_response[:meta][:pagination]).to have_key(:total_pages) }
    it { expect(json_response[:meta][:pagination]).to have_key(:total_objects) }    

    it { should respond_with 200 }      
  end

  describe "POST#create" do
  	context "when successfully create" do
  	  before(:each) do
        @participation = Participation.find(@plink_comment.participation_id)
  	  	@p_comment_attributes = FactoryGirl.attributes_for :p_comment
  	  	@p_comment_attributes[:u] = { u_id: @user.id, name: @user.name }
  	  	api_authorization_header(@user.auth_token)
  	  	post :create, { user_id: @user.id, plink_comment_id: @plink_comment.id, p_comment: @p_comment_attributes }
  	  end

  	  it "renders the json representation of the comment created" do
  	  	p_comment_response = json_response
  	  	expect(p_comment_response[:post]).to eql @p_comment_attributes[:post]
  	  end

      it "updates the participation p_link_comment" do
        @participation1 = Participation.find(@plink_comment.participation_id)
        @plink_comment1 = PlinkComment.find(@plink_comment.id)
  	    expect(@participation1.p_link_comment[:count]).to eql (@plink_comment1.p_comments.count)
      end

      it 'update user notification' do
        notification = UserNotification.find_by(post: @p_comment_attributes[:post])
        expect(notification[:viewed]).to eql false
      end

      it { should respond_with 201 }
  	end

  	context "when fail to create" do
  	  before(:each) do
  	  	@invalid_p_comment_attributes = FactoryGirl.attributes_for :p_comment
  	  	@invalid_p_comment_attributes[:u] = { u_id: @user.id, name: @user.name }
  	  	@invalid_p_comment_attributes[:post] = ""
  	  	api_authorization_header(@user.auth_token)
  	  	post :create, { user_id: @user.id, plink_comment_id: @plink_comment.id, p_comment: @invalid_p_comment_attributes }
  	  end

  	  it "renders the json errors" do
  	  	p_comment_response = json_response
  	  	expect(p_comment_response).to have_key(:errors)
  	  end

  	  it "renders the json explain why fail to create" do
  	  	p_comment_response = json_response
  	  	expect(p_comment_response[:errors][:post]).to include "can't be blank"
  	  end

  	  it { should respond_with 422 }
  	end
  end

  describe "PUT/PATCH#update" do
  	before(:each) do
  	  @p_comment = @plink_comment[:p_comments].first
  	  fetch = @p_comment["u"][:u_id]
  	  @user1 = FactoryGirl.build :user
  	  @user1[:_id] = fetch
  	  @user1.save
  	  api_authorization_header(@user1.auth_token)
  	end

  	context "when successfully updated" do
   	  before(:each) do
   	    patch :update, { user_id: @user1.id, plink_comment_id: @plink_comment.id, id: @p_comment["_id"], p_comment: { post: "Ohlala"} }
  	  end

  	  it "renders the json representation of comment updated" do
  	    p_comment_response = json_response
  	    expect(p_comment_response[:post]).to eql "Ohlala"
  	  end

  	  it { should respond_with 200 }
  	end

  	context "when fail to update" do 
  	  before(:each) do
  	  	patch :update, { user_id: @user1.id, plink_comment_id: @plink_comment.id, id: @p_comment["_id"], p_comment: { post: ""} }
  	  end

  	  it "renders the json errors" do
  	  	p_comment_response = json_response
  	  	expect(p_comment_response).to have_key(:errors)
  	  end
  	  it "renders the json explain why update fail" do
  	  	p_comment_response = json_response
  	  	expect(p_comment_response[:errors][:post]).to include "can't be blank"
  	  end

  	  it { should respond_with 422 }
  	end
  end

  describe "DELETE#destroy" do
  	before(:each) do
  	  @participation = Participation.find(@plink_comment.participation_id)
      @p_comment = @plink_comment[:p_comments].first
  	  fetch = @p_comment["u"][:u_id]
  	  @user1 = FactoryGirl.build :user
  	  @user1[:_id] = fetch
  	  @user1.save
  	  api_authorization_header(@user1.auth_token)
  	  delete :destroy, { user_id: @user1.id, plink_comment_id: @plink_comment.id, id: @p_comment["_id"]}
  	end  

    it "updates the participation p_link_comment" do
      @participation1 = Participation.find(@plink_comment.participation_id)
      @plink_comment1 = PlinkComment.find(@plink_comment.id)
      expect(@participation1.p_link_comment[:count]).to eql (@plink_comment1.p_comments.count)
    end
  	
    it { should respond_with 204 }
  end

end
