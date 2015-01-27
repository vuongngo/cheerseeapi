require 'rails_helper'

describe Message do
  let(:message) { FactoryGirl.build :message }
  subject { message }

  it { should respond_to(:u) }
  it { should respond_to(:mes) }
  it { should respond_to(:created_at) }

  it { should validate_presence_of(:u) }
  it { should validate_presence_of(:mes) }
  it { should validate_presence_of(:created_at) }
  it { should validate_uniqueness_of(:u).scoped_to(:mes, :created_at) }
end
