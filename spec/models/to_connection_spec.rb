require 'rails_helper'

describe ToConnection do
  let(:to_connection) { FactoryGirl.build :to_connection }
  subject { to_connection }

  it { should respond_to(:u) }
  it { should respond_to(:participation_id) }
  it { should respond_to(:chat_id) }
  it { should respond_to(:created_at) }
  
  it { should validate_presence_of(:u) }
  it { should validate_presence_of(:participation_id) }
  it { should validate_presence_of(:chat_id) }
  it { should validate_presence_of(:created_at) }
  it { should validate_uniqueness_of(:u) }
end
