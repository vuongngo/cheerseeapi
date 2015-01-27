require 'rails_helper'

describe CLike do
  let(:c_like) { FactoryGirl.build :c_like }
  subject { c_like }

  it { should respond_to(:u) }
  it { should respond_to(:created_at) }

  it { should validate_presence_of(:u) }
  it { should validate_presence_of(:created_at) }
  it { should validate_uniqueness_of(:u) }
end
