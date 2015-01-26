require 'rails_helper'

describe Profile do
  let(:profile) { FactoryGirl.build :profile }
  subject { profile }

  it { should respond_to(:name) }
  it { should respond_to(:gender) }
  it { should respond_to(:age) }
  it { should respond_to(:location) }
  it { should respond_to(:interests) }

  it { should validate_presence_of(:name) }
end
