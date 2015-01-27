require 'rails_helper'

describe FromConnection do
  let(:from_connection) { FactoryGirl.build :from_connection }
  subject { from_connection }

  it { should respond_to(:u) }
  it { should respond_to(:contest_id) }
  it { should respond_to(:chat_id) }
  it { should respond_to(:created_at) }
  
  it { should validate_presence_of(:u) }
  it { should validate_presence_of(:contest_id) }
  it { should validate_presence_of(:chat_id) }
  it { should validate_presence_of(:created_at) }
  it { should validate_uniqueness_of(:u) }
end
