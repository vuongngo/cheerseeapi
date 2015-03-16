require 'rails_helper'

describe Api::V1::UserNotificationsController, :type => :controller do
  before do
  	@user = FactoryGirl.create :user
  	notification_attributes = FactoryGirl.build :user_notification
  	notification_attributes.user_id = @user.id.to_s
  	notification_attributes.save
  end

  describe "GET#notification" do
  	context "when there are notifications" do
  	  before (:each) do
  	  	api_authorization_header(@user.auth_token)
  	  	get :index
  	  end

  	  it "renders the json of notifications" do
  	  	notification_response = json_response
  	  	expect(notification_response[:user_notifications][0][:viewed]).to eql false
  	  end

  	  it { should respond_with 200 }
  	end
  end

  describe "UPDATE#notification" do
  	context "when user view notifications" do
  	  before (:each) do
  	  	api_authorization_header(@user.auth_token)
  	  	get :clear_notifications
  	  end

  	  it "renders the json of updated notification" do
  	  	notification_response = json_response
  	  	expect(notification_response[:user_notifications].count).to eql 0
  	  end

  	  it { should respond_with 200 }
  	end
  end
end
