require 'rails_helper'

describe Participation do
  let(:participation) { FactoryGirl.build :participation }
  subject { participation }

  it { should respond_to(:u) }
  it { should respond_to(:post) }
  it { should respond_to(:point) }
  it { should respond_to(:winner_place) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }

  it { should validate_presence_of(:u) }
  it { should validate_presence_of(:post) }
  it { should validate_presence_of(:point) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:updated_at) }

  it { should validate_uniqueness_of(:u).scoped_to(:point, :post) }
end
