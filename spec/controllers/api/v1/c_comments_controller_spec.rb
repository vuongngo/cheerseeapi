require 'rails_helper'

describe Api::V1::CCommentsController do
  before do 
    @user = FactoryGirl.create :user
    @clink_comment = FactoryGirl.create :clink_comment
  end

  describe "GET#index" do
    before(:each) do
      api_authorization_header(@user.auth_token)
      get :index, { clink_comment_id: @clink_comment.id}
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
        @contest = Contest.find(@clink_comment.contest_id)
        @c_comment_attributes = FactoryGirl.attributes_for :c_comment
        @c_comment_attributes[:u] = { u_id: @user.id, name: @user.name }
        api_authorization_header(@user.auth_token)
        post :create, { user_id: @user.id, clink_comment_id: @clink_comment.id, c_comment: @c_comment_attributes }
      end

      it "renders the json representation for the comment just created" do
      	c_comment_response = json_response
      	expect(c_comment_response[:post]).to eql @c_comment_attributes[:post]
      end

      it "updates the contest c_link_comment" do
        @contest1 = Contest.find(@clink_comment.contest_id)
        @clink_comment1 = ClinkComment.find(@clink_comment.id)
        expect(@contest1.c_link_comment[:count]).to eql ( @clink_comment1.c_comments.count)
      end 

      # it "published to redis server" do
      #   $redis.subscribe('contest-comment', 'user-notification') do |on|
      #     on.message do |channel, message|
      #       mes = message.to_json
      #       expect(mes[:post]).to eql (@c_comment_attributes[:post])
      #     end
      #   end
      # end

      it "update user notification" do
        notification = UserNotification.find_by(post: @c_comment_attributes[:post])
        expect(notification[:viewed]).to eql false
      end
      it { should respond_with 201 }
    end

    context "when failed to create" do
      before(:each) do
      	@invalid_c_comment_attributes = FactoryGirl.attributes_for :c_comment
        @invalid_c_comment_attributes[:u] = { u_id: @user.id, name: @user.name }
      	@invalid_c_comment_attributes[:post] = ""
      	api_authorization_header(@user.auth_token)
      	post :create, { user_id: @user.id, clink_comment_id: @clink_comment.id, c_comment: @invalid_c_comment_attributes }
      end

      it "renders the json errors" do 
      	c_comment_response = json_response
      	expect(c_comment_response).to have_key(:errors)
      end

      it "renders the json on why comment fail to create" do
      	c_comment_response = json_response
      	expect(c_comment_response[:errors][:post]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT?PATCH#update" do
  	before(:each) do
  	  @c_comment = @clink_comment[:c_comments].first
 	  fetch = @c_comment["u"][:u_id]
 	  @user1 = FactoryGirl.build :user
 	  @user1[:_id] = fetch
 	  @user1.save
 	  api_authorization_header(@user1.auth_token)
  	end

  	context "when successfully updated" do
  	  before(:each) do
  	    patch :update, { user_id: @user1.id, clink_comment_id: @clink_comment.id, id: @c_comment["_id"], c_comment: { post: "How are you?"} }
  	  end

  	  it "renders the json representation of updated comment" do
  	  	c_comment_response = json_response
  	  	expect(c_comment_response[:post]).to eql "How are you?"
  	  end

  	  it { should respond_with 200 }
  	end

  	context "fail to update" do
  	  before(:each) do
  	  	patch :update, { user_id: @user1.id, clink_comment_id: @clink_comment.id, id: @c_comment["_id"], c_comment: { post: "" } }
  	  end

  	  it "render json errors" do
  	  	c_comment_response = json_response
  	  	expect(c_comment_response).to have_key(:errors)
  	  end

  	  it "render the json explain why fail to update" do
  	  	c_comment_response = json_response
  	  	expect(c_comment_response[:errors][:post]).to include "can't be blank"
  	  end

  	  it { should respond_with 422 }
  	end
  end

  describe "DELETE#destroy" do
 	before(:each) do
    @contest = Contest.find(@clink_comment.contest_id)
 	  @c_comment = @clink_comment[:c_comments].first
 	  fetch = @c_comment["u"][:u_id]
 	  @user1 = FactoryGirl.build :user
 	  @user1[:_id] = fetch
 	  @user1.save
 	  api_authorization_header(@user1.auth_token)
 	  delete :destroy, { user_id: @user1.id, clink_comment_id: @clink_comment.id, id: @c_comment["_id"] }, format: :json
 	end

  it "updates the contest c_link_comment" do
    @contest1 = Contest.find(@clink_comment.contest_id)
    @clink_comment1 = ClinkComment.find(@clink_comment.id)
    expect(@contest1.c_link_comment[:count]).to eql ( @clink_comment1.c_comments.count)
  end

 	it { should respond_with 204 }
  end

end
