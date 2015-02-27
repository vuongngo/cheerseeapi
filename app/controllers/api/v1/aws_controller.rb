class Api::V1::AwsController < ApplicationController
  require 'base64'
  require 'openssl'
  require 'digest/sha1'
  before_action :authenticate_with_token!
  respond_to :json

  def s3_access_token
  	render json: {policy: s3_upload_policy, signature: s3_upload_signature, folder: current_user.id.to_s}
  end

  protected
  	def s3_upload_policy
  	  @policy ||= create_s3_upload_policy
  	end

  	def create_s3_upload_policy
  	  Base64.encode64(
  	  {
  	  	"expiration" => 1.hour.from_now.utc.xmlschema,
  	  	"conditions" => [
  	  	  { "bucket" => "cheerseeng" },
  	  	  [ "starts-with", "$key", ""], 
  	  	  { "acl" => "private" }, 
  	  	  [ "starts-with", "$Content-Type", "" ],
  	  	  [ "starts-with", "$filename", "" ],
  	  	  [ "content-length-range", 0, 524288000 ]
  	  	]
  	  	}.to_json).gsub("\n","")
  	end

  	def s3_upload_signature
  	  Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), "TBlmzhMz7pyX2F+HHfLdwIEnzYM5kJCQNVEPAIML", s3_upload_policy)).gsub("\n","")
  	end
end
