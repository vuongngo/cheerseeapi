require 'rails_helper'

describe Api::V1::ValidationsController do
  describe "GET#email" do
  	context "when email is valid" do
  	  before(:each) do
  	    @user = FactoryGirl.create :user
  	    get :email_check, user_email: "yessir@gmail.com"
  	  end

  	  it "renders the json tells email is valid" do
  	    validations_response = json_response
  	    expect(validations_response[:isValid]).to eql true
  	  end

  	  it { should respond_with 200 }
  	end

  	context "when email is invalid" do
  	  before(:each) do
  	    @user = FactoryGirl.create :user
  	    get :email_check, user_email: @user.email
  	  end

  	  it "renders the json tells email is invalid" do
  	    validations_response = json_response
  	    expect(validations_response[:isValid]).to eql false
  	  end

  	  it { should respond_with 200 }
  	end
  end

  describe "GET #token_status" do
    context "when token is right" do
      before(:each) do
        @user = FactoryGirl.create :user
        get :token_status, :token => @user.auth_token
      end

      it { should respond_with 201 }
    end

    context "when token is wrong" do
      before(:each) do
        @user = FactoryGirl.create :user
        get :token_status, :token => SecureRandom.urlsafe_base64(nil, false)
      end
    
    it { should respond_with 401 }
  end  
  end       
end
