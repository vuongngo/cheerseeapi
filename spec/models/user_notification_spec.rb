require 'rails_helper'

describe UserNotification do
  let(:user_notification) { FactoryGirl.build :user_notification}
  subject { user_notification }

  it { should respond_to(:user_id) }
  it { should respond_to(:resource) }
  it { should respond_to(:action) }
  it { should respond_to(:element_id) }
  it { should respond_to(:u_id) }
  it { should respond_to(:name) }
  it { should respond_to(:avatar) }
  it { should respond_to(:post) }
  it { should respond_to(:created_at) }
  it { should respond_to(:viewed) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:resource) }
  it { should validate_presence_of(:action) }
  it { should validate_presence_of(:element_id) }
  it { should validate_presence_of(:u_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_at) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:resource, :action, :u_id, :created_at, :element_id) }
  it { should validate_numericality_of(:created_at) }
end
