require 'auth_token'

module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_authentication_token!
  end

  def generate_authentication_token!
    self.auth_token = loop do
      # random_token = SecureRandom.urlsafe_base64(nil, false)
      random_token = AuthToken.issue_token({rand_token: SecureRandom.urlsafe_base64(nil, false)})
      break random_token unless User.where(:auth_token => random_token).exists?
    end
  end
end