require 'rails_helper'

describe Profile do
  let(:profile) { FactoryGirl.build :profile }
  subject { profile }

  it { should respond_to(:age) }
  it { should respond_to(:location) }
  it { should respond_to(:interests) }
  it { should respond_to(:avatar) }
  it { should validate_numericality_of(:age) }
end
