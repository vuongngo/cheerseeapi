require 'rails_helper'
require 'auth_token'

describe AuthToken do
  before do
  	@token = AuthToken.issue_token(user_id: "123456789")
  	@decode_token = JWT.decode(@token, Rails.application.secrets.secret_key_base)
  end

  it "decodable" do
  	expect(@decode_token.count).to eql 2
  end

  it "equal decode method" do
  	decoded = AuthToken.valid?(@token)
  	expect(decoded).to eql @decode_token
  end
end