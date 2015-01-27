require 'rails_helper'

describe PLike do
  let(:p_like) { FactoryGirl.build :p_like }
  subject { p_like }

  it { should respond_to(:u) }
  it { should respond_to(:created_at) }

  it { should validate_presence_of(:u) }
  it { should validate_presence_of(:created_at) }
  it { should validate_uniqueness_of(:u) }
end
